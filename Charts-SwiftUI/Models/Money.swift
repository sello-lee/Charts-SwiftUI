//
//  Money.swift
//  Charts-SwiftUI
//
//  Created by sello on 05/10/2022.
//

import Charts
import Foundation

struct Money {
    static var monthArray = ["1월", "2월", "3월", "4월", "5월", "6월", "7월"]
    var month: Double
    var quantity: Double

    static var selectedItem = Money(month: -1, quantity: -1)
    static func initialItem() -> Money {
        Money(month: -1, quantity: 0)
    }

    static func moneysForHalf(money: [Money]) -> [BarChartDataEntry] {
        return money.map { BarChartDataEntry(x: $0.month, y: $0.quantity)}
    }

    static var allMoney: [Money] {
        [
            Money(month: 0, quantity: 700),
            Money(month: 1, quantity: -300),
            Money(month: 2, quantity: -600),
            Money(month: 3, quantity: -350),
            Money(month: 4, quantity: -300),
            Money(month: 5, quantity: -100),
            Money(month: 6, quantity: 200)
        ]
    }
}
