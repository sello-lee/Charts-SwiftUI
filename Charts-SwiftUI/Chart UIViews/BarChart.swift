//
//  BarChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import Charts
import SwiftUI

struct BarChart : UIViewRepresentable {
    @Binding var selectedItem: Money
    var entries : [BarChartDataEntry]
    let barChart = BarChartView()
    func makeUIView(context: Context) -> BarChartView {
        barChart.delegate = context.coordinator
        return barChart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        setChartData(uiView)
        configureChart(uiView)
        formatXAxis(xAxis: uiView.xAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }

    func setChartData(_ barChart: BarChartView) {
        let dataSet = BarChartDataSet(entries: entries)
        let barChartData = BarChartData(dataSet: dataSet)
        barChart.data = barChartData
        formatDataSet(dataSet: dataSet)
    }
    
    func formatDataSet(dataSet: BarChartDataSet) {
        dataSet.label = ""
        dataSet.highlightAlpha = 0.2
        dataSet.colors = []
        dataSet.valueColors = []
        entries.forEach { entry in
            dataSet.colors.append(entry.y > 0 ? .systemBlue : .systemPink)
            dataSet.valueColors.append(entry.y > 0 ? .systemBlue : .systemPink)
        }
        let format = NumberFormatter()
        format.numberStyle = .none
        dataSet.valueFont = .boldSystemFont(ofSize: 15)
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
    }
    
    func configureChart(_ barChart: BarChartView) {
        barChart.noDataText = "No Data"
        barChart.rightAxis.enabled = false
        barChart.setScaleEnabled(false)
        if selectedItem.month == -1 {
            barChart.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
            barChart.highlightValue(nil, callDelegate: false)
        }
        
        barChart.fitBars = true
        barChart.dragXEnabled = false

//        let marker:BalloonMarker = BalloonMarker(color: .gray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
//        marker.minimumSize = CGSize(width: 75, height: 35)
//        lineChart.marker = marker

    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Money.monthArray)
        xAxis.labelTextColor = .gray
        xAxis.labelFont = .boldSystemFont(ofSize: 15)

    }

    func formatLeftAxis(leftAxis:YAxis) {
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawZeroLineEnabled = true
        leftAxis.drawLabelsEnabled = false
    }

    func formatLegend(legend: Legend) {
        legend.enabled = false
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: BarChart
        init(parent: BarChart) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            parent.selectedItem.month = entry.x
            parent.selectedItem.quantity = entry.y
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(selectedItem: .constant(Money.selectedItem),
                 entries: Money.moneysForHalf(money: Money.allMoney))
    }
}
