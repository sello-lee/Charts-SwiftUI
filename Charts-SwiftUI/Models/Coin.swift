//
//  Coin.swift
//  KlipApp
//
//  Created by sello on 07/10/2022.
//

import SwiftUI
import Charts

struct Quote {

    var month: Double
    var quantity: Double

    static var monthArray = ["1월", "2월", "3월", "4월", "5월", "6월", "7월"]

    static func coinsForHalf(quotes: [Quote]) -> [ChartDataEntry] {
        return quotes.map { ChartDataEntry(x: $0.month, y: $0.quantity)}
    }

    static var bitcoinQuotes: [Quote] {
        [
            Quote(month: 0, quantity: 50000),
            Quote(month: 1, quantity: 70000),
            Quote(month: 2, quantity: 100000),
            Quote(month: 3, quantity: 90000),
            Quote(month: 4, quantity: 80000),
            Quote(month: 5, quantity: 75000),
            Quote(month: 6, quantity: 200000)
        ]
    }

    static var ethereumQuotes: [Quote] {
        [
            Quote(month: 0, quantity: 200000),
            Quote(month: 1, quantity: 220000),
            Quote(month: 2, quantity: 250000),
            Quote(month: 3, quantity: 280000),
            Quote(month: 4, quantity: 290000),
            Quote(month: 5, quantity: 295000),
            Quote(month: 6, quantity: 400000)
        ]
    }
}

struct Coin {
    var name: String
    var quotes: [Quote]
    var color: Color
    @Binding var show: Bool
    @State static var show1 = true
    @State static var show2 = true

    static var allCoins: [Coin] {
        [
            Coin(name: "Bitcoin", quotes: Quote.bitcoinQuotes, color: .orange, show: $show1),
            Coin(name: "Ethereum", quotes: Quote.ethereumQuotes, color: .black, show: $show2)
        ]
    }
}
