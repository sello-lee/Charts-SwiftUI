//
//  Token.swift
//  Charts-SwiftUI
//
//  Created by sello on 06/10/2022.
//

import Charts
import Foundation

struct Token {
    var value:Double
    var label:String
    var color: NSUIColor

    static func getTotal() -> Double {
        return allTokens.reduce(0) { $0 + $1.value }
    }

    static func tokensForHalf(tokens: [Token]) -> [PieChartDataEntry] {
        return tokens.map { PieChartDataEntry(value: $0.value, label: $0.label, data: $0.color)}
    }

    static var allTokens: [Token] {
        [
            Token(value: 2430000, label: "토큰", color: .systemBlue),
            Token(value: 2070000, label: "투자", color: .darkGray)
        ]
    }
}
