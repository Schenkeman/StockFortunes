//
//  PointsViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/17/21.
//

import Foundation
import Charts


//    1 month worth of 5m|15m|30m|1h, 5 years of 1d|1wk and 10 years of 1mo|3mo time
// D W M 6M 1Y 10Y


// D - 1h 1 month worth of 5m|15m|30m|1h -- 1h
// W - 1d 5 years of 1d|1wk -- 1d
// M - 7d 5 years of 1d|1wk -- 1wk
// 6M - 1m 10 years of 1mo|3mo -- 1mo
// 1Y - 4m 10 years of 1mo|3mo -- 3mo
// 10Y - 2y 10 years of 1mo|3mo -- 3mo

class PointsViewModel {
    
    var pointsModel: PointsModel {
        didSet {
            dataGranularity = DataGranularityEnum(rawValue: pointsModel.meta.dataGranularity)!
            configureFormatter()
            //            #warning("This is bad argument")
            configureData(epoch: dataCurrentEpoch)
            setData()
            listener(chartData)
        }
    }
    var dataCurrentEpoch: EpochTypeRequest = .day
    var dataGranularity: DataGranularityEnum = .h1
    var stringFormatTime: String = "HH"
    let dateFormatter = DateFormatter()
    var xValuesNumberFormatter: ChartXAxisFormatter!
    var currentDateComponent: Calendar.Component = .day
    let calendar = Calendar(identifier: .iso8601)
    let nowDate = Date()
    
    var chartValues: [ChartDataEntry]!
    var chartData: LineChartData!
    var listener: ((LineChartData) -> ())!
    
    var itemsCount: Int!
    
    lazy var yearInt = calendar.component(.year, from: nowDate)
    lazy var quarterInt = calendar.component(.quarter, from: nowDate)
    lazy var monthInt = calendar.component(.month, from: nowDate)
    lazy var weakInt = calendar.component(.weekOfMonth, from: nowDate)
    lazy var dayInt = calendar.component(.day, from: nowDate)
    
    init(pointsModel: PointsModel) {
        self.pointsModel = pointsModel
        self.dataGranularity = DataGranularityEnum(rawValue: pointsModel.meta.dataGranularity)!
        dateFormatter.timeZone = TimeZone(abbreviation: "EDT")
        configureFormatter()
        configureData(epoch: dataCurrentEpoch)
        setData()
    }
    
    private func configureData(epoch: EpochTypeRequest) {
        
        var sortedKeys = Array(pointsModel.items.keys).sorted(by: <)
        var chartValues: [ChartDataEntry] = []
        var itemsCount = 0
        
        if epoch == .day && todayIsWeekends(date: nowDate) {
            sortedKeys = sortedKeys.suffix(7)
            for key in sortedKeys {
                let itemDateDouble = Double(key)!
                guard let itemClose = pointsModel.items[key]?.closeItem else { return }
                let entry = ChartDataEntry(x: itemDateDouble, y: itemClose)
                chartValues.append(entry)
                itemsCount += 1
            }
        } else {
            switch epoch {
            case .day:
                for key in sortedKeys {
                    let itemDateDouble = Double(key)!
                    let keyDate = Date(timeIntervalSince1970: itemDateDouble)
                    if dayInt == calendar.component(.day, from: keyDate) && weakInt == calendar.component(.weekOfMonth, from: keyDate) && monthInt == calendar.component(.month, from: keyDate) {
                        guard let itemClose = pointsModel.items[key]?.closeItem else { return }
                        let entry = ChartDataEntry(x: itemDateDouble, y: itemClose)
                        chartValues.append(entry)
                        itemsCount += 1
                    }
                }
            case .week:
                for key in sortedKeys {
                    let itemDateDouble = Double(key)!
                    let keyDate = Date(timeIntervalSince1970: itemDateDouble)
                    if weakInt == calendar.component(.weekOfMonth, from: keyDate) && yearInt == calendar.component(.year, from: keyDate) && monthInt == calendar.component(.month, from: keyDate) {
                        guard let itemClose = pointsModel.items[key]?.closeItem else { return }
                        let entry = ChartDataEntry(x: itemDateDouble, y: itemClose)
                        chartValues.append(entry)
                        itemsCount += 1
                    }
                }
            case .month:
                for key in sortedKeys {
                    let itemDateDouble = Double(key)!
                    let keyDate = Date(timeIntervalSince1970: itemDateDouble)
                    if yearInt == calendar.component(.year, from: keyDate) && monthInt == calendar.component(.month, from: keyDate) {
                        guard let itemClose = pointsModel.items[key]?.closeItem else { return }
                        let entry = ChartDataEntry(x: itemDateDouble, y: itemClose)
                        chartValues.append(entry)
                        itemsCount += 1
                    }
                }
            case .sixMonth:
                let sortedKeys = sortedKeys.suffix(6)
                stringFormatTime = "MMM"
                for key in sortedKeys {
                    let itemDateDouble = Double(key)!
                    guard let itemClose = pointsModel.items[key]?.closeItem else { return }
                    let entry = ChartDataEntry(x: itemDateDouble, y: itemClose)
                    chartValues.append(entry)
                    itemsCount += 1
                }
            case .oneYear:
                let sortedKeys = sortedKeys.suffix(4)
                for key in sortedKeys {
                    let itemDateDouble = Double(key)!
                    guard let itemClose = pointsModel.items[key]?.closeItem else { return }
                    let entry = ChartDataEntry(x: itemDateDouble, y: itemClose)
                    chartValues.append(entry)
                    itemsCount += 1
                }
            }
        }
        self.chartValues = chartValues
        self.itemsCount = itemsCount
        dateFormatter.dateFormat = stringFormatTime
        xValuesNumberFormatter = ChartXAxisFormatter(dateFormatter: dateFormatter)
    }
    
    func configureFormatter() {
        switch dataGranularity {
        case .h1:
            stringFormatTime = "HH"
        case .d1:
            stringFormatTime = "dd"
        case .wk1:
            stringFormatTime = "dd"
        case .mo1:
            stringFormatTime = "dd"
        case .mo3:
            stringFormatTime = "MMM"
        }
    }
    
    func setData() {
        let dataSet = LineChartDataSet(entries: chartValues, label: nil)
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.setColor(.black)
        dataSet.highlightColor = .red
        dataSet.lineWidth = 2
        dataSet.fill = Fill(color: .lightGray)
        dataSet.fillAlpha = 0.5
        dataSet.drawFilledEnabled = true
        dataSet.highlightLineWidth = 1
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        let data = LineChartData(dataSet: dataSet)
        chartData = data
    }
    
    func todayIsWeekends(date: Date) -> Bool {
        calendar.isDateInWeekend(date)
    }
    
    func getDataEpochIntDate(component: Calendar.Component, date: Date) -> Int {
        return calendar.component(component, from: date)
    }
}

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter?
    
    convenience init(dateFormatter: DateFormatter) {
        self.init()
        self.dateFormatter = dateFormatter
    }
}

extension ChartXAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateFormatter = dateFormatter else { return "" }
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
    
}

