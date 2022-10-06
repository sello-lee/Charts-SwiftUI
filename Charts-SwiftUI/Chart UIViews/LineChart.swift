//
//  LineChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import Charts
import SwiftUI

struct LineChart: UIViewRepresentable {
    let lineChart = LineChartView()
    var klay: [ChartDataEntry]
    var scnr: [ChartDataEntry]
    var matic: [ChartDataEntry]

    @Binding var klayButton: Bool
    @Binding var scnrButton: Bool
    @Binding var maticButton: Bool

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
        let dataKlay = LineChartDataSet(entries: klay)
        let dataScnr = LineChartDataSet(entries: scnr)
        let dataMatic = LineChartDataSet(entries: matic)

        var dataSets: [LineChartDataSet] = []
        if klayButton { dataSets.append(dataKlay) }
        if scnrButton { dataSets.append(dataScnr) }
        if maticButton { dataSets.append(dataMatic) }

        let lineChartData = LineChartData(dataSets: dataSets)
        lineChart.data = lineChartData
        formatDataSet(dataSet: dataKlay, label: "KLAY", color: .systemPink)
        formatDataSet(dataSet: dataScnr, label: "SCNR", color: .systemGreen)
        formatDataSet(dataSet: dataMatic, label: "MATIC", color: .systemPurple)
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
        let marker:BalloonMarker = BalloonMarker(color: .gray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75, height: 35)
        lineChart.marker = marker
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IndexAxisValueFormatter(values:Coin.monthArray)
        xAxis.labelTextColor =  .gray
        xAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
        // Setting the max and min make sure that the markers are visible at the edges
        xAxis.axisMaximum = 6
        xAxis.axisMinimum = 0
    }
    
    func formatLeftAxis(leftAxis:YAxis) {
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
    @State static var klayButton: Bool = true
    @State static var scnrButton: Bool = true
    @State static var maticButton: Bool = true

    static var previews: some View {
        LineChart(
            klay: Coin.coinsForHalf(coins: Coin.allCoins, coinType: .KLAY),
            scnr: Coin.coinsForHalf(coins: Coin.allCoins, coinType: .SCNR),
            matic: Coin.coinsForHalf(coins: Coin.allCoins, coinType: .MATIC),
            klayButton: $klayButton,
            scnrButton: $scnrButton,
            maticButton: $maticButton
        )
        .frame(height: 400)
        .padding(.horizontal)
    }
}
