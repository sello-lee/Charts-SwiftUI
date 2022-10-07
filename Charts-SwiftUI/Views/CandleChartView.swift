//
//  CandleChartView.swift
//  Charts-SwiftUI
//
//  Created by sello on 07/10/2022.
//

import SwiftUI
import Charts

struct CandleChartView: View {
    var body: some View {
        VStack {
            Text("코인 시세 추이")
                .font(.largeTitle)
                .bold()
            Divider()
            CandleStickChart(entries: Candle.candles(for: .day))
            .frame(height: 400)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct CandleChartView_Previews: PreviewProvider {
    static var previews: some View {
        CandleChartView()
    }
}
