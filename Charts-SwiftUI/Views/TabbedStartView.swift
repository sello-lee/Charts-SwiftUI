//
//  TabbedStartView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import SwiftUI


struct TabbedStartView: View {
    var body: some View {
        TabView {
            GroupedBCView()
                .tabItem {
                    Image("Grouped")
                    Text("Grouped Bar Chart")
                }
            BCView()
                .tabItem {
                    Image("BarChart")
                    Text("Bar Chart")
                }

            PCView()
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Pie Chart")
                }
            LineChrtView()
                .tabItem {
                    Image("StackedLine")
                    Text("Stacked Line Chart")
                }
//            CombinedChrtView()
//                .tabItem {
//                    Image("StackedBarLine")
//                    Text("Bar + Line Chart")
//                }
            CandleChartView()
                .tabItem {
                    Image("StackedBarLine")
                    Text("Candle Stick Chart")
                }

        }
    }
}

struct TabbedStartView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedStartView()
    }
}
