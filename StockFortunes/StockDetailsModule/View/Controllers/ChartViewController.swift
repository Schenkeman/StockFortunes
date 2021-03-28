//
//  ChartViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/3/21.
//

import UIKit
import Charts
import JGProgressHUD

class ChartViewController: UIViewController {
    
    let networkManager = NetworkManager()
    var points: PointsModel! {
        didSet {
            setDataForPoints()
        }
    }
    
    var ticker: String!
    var labelCount: Int!
    
    var pointsViewModel: PointsViewModel!
    var buttonsCollection: EpochCollectionView!
    
    var dateFormatter = DateFormatter()
    let hud = JGProgressHUD(style: .dark)
    
    
    init(ticker: String) {
        super.init(nibName: nil, bundle: nil)
        self.ticker = ticker
        //        let pointsModel = MockServer.fetchPoints(file: ticker, epoch: .day)
        //        pointsViewModel = PointsViewModel(pointsModel: pointsModel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        handleFetchPoints(ticker: ticker, epochType: .day)
        lineChartView.delegate = self
        configureLineChartView()
        configureButtonsCollection()
        setDateFormatter()
        buttonsCollection.delegate = self
    }
    
    var selectedEpochType: EpochType! = .day {
        didSet {
            switch selectedEpochType {
            case .day:
                xValueLabel.text = "Current Day"
                yValueLabel.text = "Stock's value in USD"
                dateFormatter.dateFormat = "MMM d, h:mm a"
                pointsViewModel.dataCurrentEpoch = .day
                pointsViewModel.pointsModel = MockServer.fetchPoints(file: ticker, epoch: .day)
            case .week:
                xValueLabel.text = "1 Week"
                yValueLabel.text = "Stock's value in USD"
                dateFormatter.dateFormat = "MMM d"
                pointsViewModel.dataCurrentEpoch = .week
                pointsViewModel.pointsModel = MockServer.fetchPoints(file: ticker, epoch: .week)
            case .month:
                xValueLabel.text = "1 Month"
                yValueLabel.text = "Stock's value in USD"
                dateFormatter.dateFormat = "MMM d"
                pointsViewModel.dataCurrentEpoch = .month
                pointsViewModel.pointsModel = MockServer.fetchPoints(file: ticker, epoch: .month)
            case .sixMonth:
                xValueLabel.text = "6 Months"
                yValueLabel.text = "Stock's value in USD"
                dateFormatter.dateFormat = "YY MMM d"
                pointsViewModel.dataCurrentEpoch = .sixMonth
                pointsViewModel.pointsModel = MockServer.fetchPoints(file: ticker, epoch: .sixMonth)
            case .oneYear:
                xValueLabel.text = "1 Year"
                yValueLabel.text = "Stock's value in USD"
                dateFormatter.dateFormat = "YYYY MMM d"
                pointsViewModel.dataCurrentEpoch = .oneYear
                pointsViewModel.pointsModel = MockServer.fetchPoints(file: ticker, epoch: .oneYear)
            case .none:
                return
            }
        }
    }
    
    let lineChartView: LineChartView = {
        let lcv = LineChartView()
        lcv.rightAxis.enabled = false
        lcv.doubleTapToZoomEnabled = false
        let yAxis = lcv.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        
        let xAxis = lcv.xAxis
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.labelPosition = .bottom
        return lcv
    }()
    let xValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Current Day"
        
        label.textAlignment = .center
        return label
    }()
    
    let yValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Stock's value in USD"
        
        label.textAlignment = .center
        return label
    }()
    
    
    func configureButtonsCollection() {
        buttonsCollection = EpochCollectionView(frame: .zero)
        view.addSubview(buttonsCollection)
        buttonsCollection.anchor(top: lineChartView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingRight: 32, height: 50)
        
    }
    
    private func configureLineChartView() {
        let stack = UIStackView(arrangedSubviews: [xValueLabel, yValueLabel])
        view.addSubview(stack)
        view.addSubview(lineChartView)
        stack.spacing = 8
        stack.axis = .vertical
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16)
        xValueLabel.centerX(inView: view)
        lineChartView.anchor(top: yValueLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 32, paddingBottom: 150, paddingRight: 32)
    }
    
    private func setLabelsCount(count: Int) {
        lineChartView.xAxis.setLabelCount(count, force: true)
        lineChartView.leftAxis.setLabelCount(count, force: true)
    }
    
    private func setDateFormatter() {
        dateFormatter.timeZone = TimeZone(abbreviation: "EDT")
        dateFormatter.dateFormat = "MMM d, h:mm a"
    }
    
    
    private func handleFetchPoints(ticker: String, epochType: EpochTypeRequest)  {
        
        hud.show(in: view)
        //        networkManager.fetchChartData(ticker: ticker, epochType: epochType) { [weak self] (pointsModel, error) in
        //            guard let self = self, let pointsModel = pointsModel else { return }
        //            self.points = pointsModel
        //        }
        points = MockServer.fetchPoints(file: ticker, epoch: epochType)
        hud.dismiss()
    }
    
    private func setDataForPoints() {
        pointsViewModel = PointsViewModel(pointsModel: points)
        labelCount = pointsViewModel.itemsCount
        lineChartView.data = pointsViewModel.chartData
        setLabelsCount(count: labelCount)
        lineChartView.xAxis.valueFormatter = pointsViewModel.xValuesNumberFormatter!
        pointsViewModel.listener = { [weak self] data in
            guard let self = self else { return }
            self.lineChartView.data = data
            self.labelCount = self.pointsViewModel.itemsCount
            self.setLabelsCount(count: self.labelCount)
            self.lineChartView.xAxis.valueFormatter = self.pointsViewModel.xValuesNumberFormatter!
        }
    }
}

extension ChartViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        xValueLabel.text = "\(dateFormatter.string(from: Date(timeIntervalSince1970: entry.x)))"
        yValueLabel.text = "\(entry.y)"
    }
}

extension ChartViewController: EpochCollectionViewDelegate {
    func filterView(_ view: EpochCollectionView, didSelect indexPath: IndexPath) {
        guard let epochType = EpochType(rawValue: indexPath.row) else { return }
        self.selectedEpochType = epochType
    }
}

