//
//  CoordinateViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/6/21.
//

import Foundation
import Charts

class CoordinateViewModel {
    
    var dayItemsModel: CoordinatesModel?
    var weekItemsModel: CoordinatesModel?
    var monthItemsModel: CoordinatesModel?
    
    var items: [ItemModel] = []
    var filteredItems: [ItemModel] = []
    
    var itemCloseList: [Double] = []
    var dates: [Double] = []
    var formattedDates: [String] = []
    
    var chartValues: [ChartDataEntry] = []
    var xValuesNumberFormatter: ChartXAxisFormatter!
    
    var stringFormatTime: String = "HH"
    
    var chartData: LineChartData!
    var listener: ((LineChartData) -> ())!
    var selectedEpoch: EpochTypeRequest! = .day {
        didSet {
            configureModel(selectedEpoch)
        }
    }
    var selectedItemsModel: CoordinatesModel? {
        didSet {
            setModel(coordinatesModel: selectedItemsModel!)
            setCustomeXFortmatter()
            setData()
            listener(chartData)
            dates = []
            filteredItems = []
            items = []
            itemCloseList = []
            chartValues = []
        }
    }
    
    func configureModel(_ epoch: EpochTypeRequest )  {
        switch epoch {
        case .day:
            stringFormatTime = "HH"
        case .week:
            stringFormatTime = "d"
        default:
            return
        }
    }
    
    func setModel(coordinatesModel: CoordinatesModel) {
        let sortedKeys = Array(coordinatesModel.items.keys).sorted(by: <)
        for key in sortedKeys.suffix(7) {
            let date = Double(key)!
            dates.append(date)
            guard let item = coordinatesModel.items[key] else { return }
            items.append(item)
            //            let xValue = Double((dateFormatter.string(from: date)))!
            guard let closeItem = coordinatesModel.items[key]?.closeItem else { return }
            itemCloseList.append(closeItem)
        }
        let lastTime = items.last!.dateItem
//        filteredItems = items.filter { $0.dateItem == lastTime }
//        dates = dates.suffix(filteredItems.count)
    }
    
    func setEntryes(referenceTimeInterval: Double) {
        
        for i in 0 ..< itemCloseList.count {
            let timeInterval = dates[i]
            let xValue = (timeInterval - referenceTimeInterval)
//            let xValue = timeInterval
            
            let yValue = itemCloseList[i]
            let entry = ChartDataEntry(x: xValue, y: yValue)
            chartValues.append(entry)
        }
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: chartValues, label: "values yo")
        set1.drawCirclesEnabled = false
        set1.setColor(.black)
        set1.highlightColor = .red
        let data = LineChartData(dataSet: set1)
        chartData = data
    }
    
    func setCustomeXFortmatter() {
        var referenceTimeInterval: TimeInterval = 0
        if let minTimeInterval = dates.min() {
            referenceTimeInterval = minTimeInterval
        }
        
        let xValuesFormatter = DateFormatter()
        xValuesFormatter.dateFormat = stringFormatTime
        xValuesFormatter.timeZone = TimeZone(abbreviation: "EDT")
        
        
        let xValuesNumberFormatter = ChartXAxisFormatter(referenceTimeInterval: referenceTimeInterval, dateFormatter: xValuesFormatter)
        self.xValuesNumberFormatter = xValuesNumberFormatter
        
        setEntryes(referenceTimeInterval: referenceTimeInterval)
        
    }
}
        
enum EpochType: Int, CaseIterable {
    case day
    case week
    case month
    case sixMonth
    case oneYear
    case tenYears
    
    var description: String {
        switch self {
        case .day: return "D"
        case .week: return "W"
        case .month: return "M"
        case .sixMonth: return "6M"
        case .oneYear: return "1Y"
        case .tenYears: return "10Y"
        }
    }
}

enum EpochTypeRequest: Int, CaseIterable {
    case day
    case week
    case month
    case sixMonth
    case oneYear
    case tenYears
    
    var description: String {
        switch self {
        case .day: return "1h"
        case .week: return "1wk"
        case .month: return "1mo"
        case .sixMonth: return "3mo"
        case .oneYear: return "3mo"
        case .tenYears: return "3mo"
        }
    }
}

class DayEpochGraph {
    var itemsClose: [Double]!
    var dates: [Double]!
    
    init(itemsClose: [Double], dates: [Double]) {
        self.itemsClose = itemsClose
        self.dates = dates
    }
}

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter?
    fileprivate var referenceTimeInterval: TimeInterval?
    
    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
        self.init()
        self.referenceTimeInterval = referenceTimeInterval
        self.dateFormatter = dateFormatter
    }
}

extension ChartXAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateFormatter = dateFormatter,
              let referenceTimeInterval = referenceTimeInterval
        else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: value + referenceTimeInterval)
        return dateFormatter.string(from: date)
    }
    
}


