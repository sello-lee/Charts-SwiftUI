//
//  Candle.swift
//  Charts-SwiftUI
//
//  Created by sello on 07/10/2022.
//

import Foundation
import Charts

struct Candle {
    enum Term: Int {
        case day = 31
        case month = 12
    }

    var value: Double
    var high: Double
    var low: Double
    var open: Double
    var close: Double

    static func candles(for term: Term) -> [CandleChartDataEntry] {
        var temp: Double = 0

        return (1...term.rawValue).map { i -> CandleChartDataEntry in
            let sign = Double([-1, 1].randomElement()!)
            let val = Double(arc4random_uniform(40))
            let open = temp
            let close = open + (sign * val)
            let high = Double(arc4random_uniform(9))
            let low = Double(arc4random_uniform(9))
            temp = close

            return CandleChartDataEntry(x: Double(i), shadowH: sign > 0 ? close + high : open + high, shadowL: sign > 0 ? open - low : close - low, open: open, close: close)
        }
    }
}
