//
//  ChartViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/3/21.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    var pointsViewModel: PointsViewModel!
    
    var buttonsCollection: EpochCollectionView!
    var ticker: String!
    var labelCount: Int!
    
    init(ticker: String) {
        super.init(nibName: nil, bundle: nil)
        self.ticker = ticker
        let pointsModel = MockServer.fetchPoints(file: ticker, epoch: .day)
        pointsViewModel = PointsViewModel(pointsModel: pointsModel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    1 month worth of 5m|15m|30m|1h, 5 years of 1d|1wk and 10 years of 1mo|3mo time
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pointsViewModel.listener = { [weak self] data in
            guard let self = self else { return }
            self.lineChartView.data = data
            self.configureGraphViewByType(count: self.labelCount)
        }
        labelCount = pointsViewModel.itemsCount
        lineChartView.data = pointsViewModel.chartData
        lineChartView.xAxis.valueFormatter = pointsViewModel.xValuesNumberFormatter!
        configureHostView()
        configureGraphViewByType(count: labelCount)
        configureButtonsCollection()
        buttonsCollection.delegate = self
        
    }

    
    // D - 1h 1 month worth of 5m|15m|30m|1h -- 1h
    // W - 1d 5 years of 1d|1wk -- 1d
    // M - 7d 5 years of 1d|1wk -- 1wk
    // 6M - 1m 10 years of 1mo|3mo -- 1mo
    // 1Y - 4m 10 years of 1mo|3mo -- 3mo
    // 10Y - 2y 10 years of 1mo|3mo -- 3mo
    
    var selectedEpochType: EpochType! = .day {
        didSet {
            switch selectedEpochType {
            case .day:
                pointsViewModel.dataCurrentEpoch = .day
                pointsViewModel.pointsModel = MockServer.fetchPoints(file: ticker, epoch: .day)
            case .week:
                pointsViewModel.dataCurrentEpoch = .week
                pointsViewModel.pointsModel = MockServer.fetchPoints(file: ticker, epoch: .week)
            case .month:
                pointsViewModel.dataCurrentEpoch = .month
                pointsViewModel.pointsModel = MockServer.fetchPoints(file: ticker, epoch: .month)
            case .sixMonth:
                pointsViewModel.dataCurrentEpoch = .sixMonth
                pointsViewModel.pointsModel = MockServer.fetchPoints(file: ticker, epoch: .sixMonth)
            case .oneYear:
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
        
    func configureButtonsCollection() {
        buttonsCollection = EpochCollectionView(frame: .zero)
        view.addSubview(buttonsCollection)
        buttonsCollection.anchor(top: lineChartView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingRight: 32, height: 50)
        
    }
    
    
    private func configureHostView() {
        view.addSubview(lineChartView)
        lineChartView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 32, paddingBottom: 150, paddingRight: 32)
        
    }
    
    private func configureGraphViewByType(count: Int) {
        lineChartView.xAxis.setLabelCount(count, force: true)
        lineChartView.leftAxis.setLabelCount(count, force: true)
    }
    
}
extension ChartViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

extension ChartViewController: EpochCollectionViewDelegate {
    func filterView(_ view: EpochCollectionView, didSelect indexPath: IndexPath) {
        guard let epochType = EpochType(rawValue: indexPath.row) else { return }
        self.selectedEpochType = epochType
    }
}





