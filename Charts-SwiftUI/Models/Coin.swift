//
//  Coin.swift
//  Charts-SwiftUI
//
//  Created by sello on 06/10/2022.
//

import Charts
import Foundation

struct Coin {

    enum CoinType {
        case KLAY, SCNR, MATIC, none
    }

    var month: Double
    var quantity: Double
    var coinType: CoinType

    static var selectedItem = Coin(month: -1, quantity: -1, coinType: .none)
    static func initialItem() -> Coin {
        Coin(month: -1, quantity: 0, coinType: .none)
    }

    static var monthArray = ["1월", "2월", "3월", "4월", "5월", "6월", "7월"]
    static func coinsForHalf(coins: [Coin], coinType: CoinType) -> [ChartDataEntry] {
        let halfData = coins.filter { $0.coinType == coinType }
        return halfData.map { ChartDataEntry(x: $0.month, y: $0.quantity)}
    }

    static var allCoins: [Coin] {
        [
            Coin(month: 0, quantity: 50000, coinType: .KLAY),
            Coin(month: 1, quantity: 70000, coinType: .KLAY),
            Coin(month: 2, quantity: 100000, coinType: .KLAY),
            Coin(month: 3, quantity: 90000, coinType: .KLAY),
            Coin(month: 4, quantity: 80000, coinType: .KLAY),
            Coin(month: 5, quantity: 75000, coinType: .KLAY),
            Coin(month: 6, quantity: 200000, coinType: .KLAY),

            Coin(month: 0, quantity: 200000, coinType: .SCNR),
            Coin(month: 1, quantity: 220000, coinType: .SCNR),
            Coin(month: 2, quantity: 250000, coinType: .SCNR),
            Coin(month: 3, quantity: 280000, coinType: .SCNR),
            Coin(month: 4, quantity: 290000, coinType: .SCNR),
            Coin(month: 5, quantity: 295000, coinType: .SCNR),
            Coin(month: 6, quantity: 410000, coinType: .SCNR),

            Coin(month: 0, quantity: 20000, coinType: .MATIC),
            Coin(month: 1, quantity: 20000, coinType: .MATIC),
            Coin(month: 2, quantity: 30000, coinType: .MATIC),
            Coin(month: 3, quantity: 45000, coinType: .MATIC),
            Coin(month: 4, quantity: 50000, coinType: .MATIC),
            Coin(month: 5, quantity: 40000, coinType: .MATIC),
            Coin(month: 6, quantity: 20000, coinType: .MATIC)
        ]
    }
}
