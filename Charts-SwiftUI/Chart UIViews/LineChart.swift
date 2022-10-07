//
//  LineChart.swift
//  KlipApp
//
//  Created by sello on 07/10/2022.
//

import Charts
import SwiftUI

struct LineChart: UIViewRepresentable {
    let lineChart = LineChartView()
    var coins: [Coin]
    @Binding var buttonDic: [String:Bool]

    func makeUIView(context: Context) -> LineChartView {
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        setChartData(uiView)
        configureChart(uiView)
        formatXAxis(xAxis: uiView.xAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }

    func setChartData(_ lineChart: LineChartView) {
        var dataSets: [LineChartDataSet] = []

        coins.forEach { coin in
            let quotes = coin.quotes
            let data = LineChartDataSet(entries: Quote.coinsForHalf(quotes: quotes))
            formatDataSet(dataSet: data, label: coin.name, color: UIColor(coin.color))
            guard let flag = buttonDic[coin.name] else { return }
            if flag { dataSets.append(data) }
        }

        let lineChartData = LineChartData(dataSets: dataSets)
        lineChart.data = lineChartData
    }

    func formatDataSet(dataSet: LineChartDataSet, label: String, color: UIColor) {
        dataSet.label = label
        dataSet.colors = [color]
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 4
    }

    func configureChart(_ lineChart: LineChartView) {
        lineChart.noDataText = "No Data"
        lineChart.rightAxis.enabled = false
        lineChart.setScaleEnabled(false)
        lineChart.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
//        let marker:BalloonMarker = BalloonMarker(color: .gray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
//        marker.minimumSize = CGSize(width: 75, height: 35)
//        lineChart.marker = marker
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Quote.monthArray)
        xAxis.labelTextColor =  .gray
        xAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
        // Setting the max and min make sure that the markers are visible at the edges
        xAxis.axisMaximum = 6
        xAxis.axisMinimum = 0
    }

    func formatLeftAxis(leftAxis: YAxis) {
        leftAxis.drawAxisLineEnabled = false
        leftAxis.axisMaximum = 500000
        leftAxis.axisMinimum = 0
        leftAxis.labelCount = 3
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelTextColor =  .gray
        leftAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
    }

    func formatLegend(legend: Legend) {
        legend.enabled = false
    }
}

struct LineChart_Previews: PreviewProvider {
    @State static var buttonDic: [String:Bool] = [:]
    static var coins = Coin.allCoins

    static var previews: some View {
        LineChart(
            coins: coins,
            buttonDic: $buttonDic
        )
        .frame(height: 400)
        .padding(.horizontal)
    }
}
