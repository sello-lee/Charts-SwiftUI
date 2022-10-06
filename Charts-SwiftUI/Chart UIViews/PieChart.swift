//
//  PieChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//
import Charts
import SwiftUI

struct PieChart: UIViewRepresentable {
    var entries: [PieChartDataEntry]
    var total: Double
    let pieChart = PieChartView()
    var defaultCenterText: String = "%"

    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        setChartData(uiView)
        configureChart(uiView)
        formatCenter(uiView)
//        formatDescription(description: uiView.chartDescription)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }

    func setChartData(_ pieChart: PieChartView) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = []
        entries.forEach { entry in
            if let color = entry.data as? UIColor {
                dataSet.colors.append(color)
            }
        }
        let pieChartData = PieChartData(dataSet: dataSet)

        pieChart.data = pieChartData
        formatDataSet(dataSet: dataSet)
    }
    
    func formatDataSet(dataSet: ChartDataSet) {
        dataSet.drawValuesEnabled = false
    }
    
    func configureChart(_ pieChart: PieChartView) {
        pieChart.noDataText = "No Data"
        pieChart.rotationEnabled = false
        pieChart.animate(yAxisDuration: 0.5, easingOption: .easeInOutCirc)
//        pieChart.drawEntryLabelsEnabled = false
        pieChart.data?.setValueTextColor(.white)
        pieChart.data?.setValueFont(.boldSystemFont(ofSize: 30))
        pieChart.usePercentValuesEnabled = true
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
    }
    
    func formatCenter(_ pieChart: PieChartView) {
        pieChart.holeColor = UIColor.systemBackground
        pieChart.centerTextRadiusPercent = 0.95
        pieChart.centerAttributedText = PieChart.setCenterText(defaultCenterText)

    }

//    func formatDescription(description: Description) {
//        description.font = UIFont.boldSystemFont(ofSize: 17)
//        description.textColor = .systemBlue
//    }

    func formatLegend(legend: Legend) {
        legend.enabled = false
    }
    
    static func setCenterText(_ text: String, color: UIColor = .black) -> NSAttributedString{
        let font = UIFont.systemFont(ofSize: 40, weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        let centerText = NSAttributedString(string: text, attributes: attributes)
        return centerText
    }


    class Coordinator: NSObject, ChartViewDelegate {
        var parent: PieChart
        init(parent: PieChart) {
            self.parent = parent
        }

        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let value =  entry.value(forKey: "value")! as! Double
            let color = entry.data as? UIColor
            parent.pieChart.centerAttributedText = setCenterText("\(value / parent.total * 100)%", color: color!)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(entries: Token.tokensForHalf(tokens: Token.allTokens), total: Token.getTotal())
            .frame(height: 400)
            .padding(.horizontal)
    }
}
