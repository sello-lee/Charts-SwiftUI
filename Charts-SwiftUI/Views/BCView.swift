//
//  ContentView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import SwiftUI
import Charts

struct BCView: View {

    @State private var selectedItem: Money = Money.initialItem()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("총 자산 추이")
                    .font(.largeTitle)
                    .bold()
                Text("지난달 보다 +3,000,000원 늘었어요")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .bold()
                BarChart(selectedItem: $selectedItem,
                         entries: Money.moneysForHalf(money: Money.allMoney))
                .frame(height: 300)
            }
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BCView()
    }
}
