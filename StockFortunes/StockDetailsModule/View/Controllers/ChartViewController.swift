//
//  ChartViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/3/21.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    var coordinateViewModel: CoordinateViewModel!
    var coordinatesModel: CoordinatesModel? {
        didSet {
            coordinateViewModel.selectedItemsModel = coordinatesModel
        }
    }
    
    var buttonsCollection: EpochCollectionView!
    var ticker: String!
    
    init(ticker: String) {
        super.init(nibName: nil, bundle: nil)
        self.ticker = ticker
        coordinateViewModel = CoordinateViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    1 month worth of 5m|15m|30m|1h, 5 years of 1d|1wk and 10 years of 1mo|3mo time
    override func viewDidLoad() {
        
        super.viewDidLoad()
        coordinateViewModel.listener = { [weak self] data in
            guard let self = self else { return }
            self.lineChartView.data = data
        }
        coordinatesModel = fetchCoordinates(file: ticker, epoch: .day)
        lineChartView.data = coordinateViewModel.chartData
        configureHostView()
        configureButtonsCollection()
        buttonsCollection.delegate = self
    }
    var selectedEpochRequest: EpochTypeRequest = .day {
        didSet {
            coordinatesModel = fetchCoordinates(file: ticker, epoch: selectedEpochRequest)
        }
    }
    var selectedEpochType: EpochType! = .day {
        didSet {
            selectEpochType(type: selectedEpochType)
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
    
    func fetchCoordinates(file: String, epoch: EpochTypeRequest) -> CoordinatesModel {
        coordinateViewModel.selectedEpoch = epoch
        let dataCoordinate = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(file)_\(epoch.description)", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let coordinatesModels = try! JSONDecoder().decode(CoordinatesModel.self, from: dataCoordinate)
        return coordinatesModels
    }
    
    func configureButtonsCollection() {
        buttonsCollection = EpochCollectionView(frame: .zero)
        view.addSubview(buttonsCollection)
        buttonsCollection.anchor(top: lineChartView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingRight: 32, height: 50)
        lineChartView.xAxis.valueFormatter = coordinateViewModel.xValuesNumberFormatter!
    }
    
    func selectEpochType(type: EpochType) {
        var count = 7
        let itemsCount = coordinateViewModel.filteredItems.count
        count = itemsCount > count ? 7 : itemsCount
        switch type {
        case .day:
            selectedEpochRequest = .day
            coordinatesModel = fetchCoordinates(file: ticker, epoch: selectedEpochRequest)
//            configureGraphViewByType(count: count)
        case .week:
            selectedEpochRequest = .week
            coordinatesModel = fetchCoordinates(file: ticker, epoch: selectedEpochRequest)
//            configureGraphViewByType(count: count)
        case .month:
            configureGraphViewByType(count: count)
        case .sixMonth:
            configureGraphViewByType(count: count)
        case .oneYear:
            configureGraphViewByType(count: count)
        case .tenYears:
            configureGraphViewByType(count: count)
        }
    }
    //    let hostView = HostedGraphView()
    
    private func configureHostView() {
        view.addSubview(lineChartView)
        lineChartView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 32, paddingBottom: 150, paddingRight: 32)
        
    }
    
    private func configureGraphViewByType(count: Int) {
        lineChartView.xAxis.setLabelCount(count, force: false)
        lineChartView.leftAxis.setLabelCount(count, force: false)
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





