//
//  CandleStickChart.swift
//  Charts-SwiftUI
//
//  Created by sello on 07/10/2022.
//

import SwiftUI
import Charts

struct CandleStickChart: UIViewRepresentable {
    var entries : [CandleChartDataEntry]
    var candleChart = CandleStickChartView()

    func makeUIView(context: Context) -> CandleStickChartView {
        candleChart.delegate = context.coordinator
        return candleChart
    }

    func updateUIView(_ uiView: CandleStickChartView, context: Context) {
        setChartData(uiView)
        configureChart(uiView)
        formatXAxis(uiView.xAxis)
        formatLeftAxis(uiView.leftAxis)
        formatRightAxis(uiView.rightAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }

    func setChartData(_ candleStickChart: CandleStickChartView) {
        let dataSet = CandleChartDataSet(entries: entries)
        dataSet.decreasingColor = .systemBlue
        dataSet.decreasingFilled = true
        dataSet.increasingColor = .systemRed
        dataSet.increasingFilled = true
        dataSet.shadowColor = .darkGray
        dataSet.shadowWidth = 0.7
        dataSet.drawValuesEnabled = false

        let candleChartData = CandleChartData(dataSet: dataSet)
        candleChart.data = candleChartData
    }

    func configureChart(_ candleChart: CandleStickChartView) {
        candleChart.noDataText = "No Data"
        candleChart.setScaleEnabled(false)
        candleChart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5, easingOption: .linear)
        candleChart.fitScreen()
        let marker: BalloonMarker = BalloonMarker(color: .darkGray, font: .systemFont(ofSize: 12), textColor: .white, insets: .init(top: 7, left: 7, bottom: 7, right: 7))
        marker.setEntries(entries)
        candleChart.marker = marker
    }

    func formatXAxis(_ xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 15)
        xAxis.labelTextColor = .gray
    }

    func formatLeftAxis(_ leftAxis: YAxis) {
        leftAxis.spaceTop = 0.3
        leftAxis.spaceBottom = 0.3
        leftAxis.labelFont = .boldSystemFont(ofSize: 15)
        leftAxis.labelTextColor = .gray
    }

    func formatRightAxis(_ rightAxis: YAxis) {
        rightAxis.enabled = false
    }

    func formatLegend(legend: Legend) {
        legend.enabled = false
    }

    class Coordinator: NSObject, ChartViewDelegate {
        let parent: CandleStickChart
        init(parent: CandleStickChart) {
            self.parent = parent
        }
        private func chartValueSelected(_ chartView: ChartViewBase, entry: CandleChartDataEntry, highlight: Highlight) {
//            parent.selectedItem.month = entry.x
//            parent.selectedItem.quantity = entry.y
            print("hi")
            print(entry.open, entry.close, entry.shadowRange)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

struct CandelStickChart_Previews: PreviewProvider {
    static var previews: some View {
        CandleStickChart(entries: Candle.candles(for: .day))
    }
}
