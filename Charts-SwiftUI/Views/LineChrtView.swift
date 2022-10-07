//
//  LineChrtView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import SwiftUI
import Charts

struct LineChrtView: View {
    @State var buttonDic: [String:Bool] = [:]
    @State private var coins = Coin.allCoins

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("총 코인 수량 추이")
                    .font(.largeTitle)
                    .bold()
                Text("2022년 기준 월별 코인 수량 변화를 알려드려요.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .bold()
                    HStack {
                        ForEach(0..<coins.indices) { index in
                            let i = Int(index)
                            Button(coins[i].name) {
                                coins[i].show.toggle()
                            }
                            .padding(10)
                            .border(coins[i].color)
                            .background(coins[i].show ? coins[i].color : Color.white)
                            .foregroundColor(coins[i].show ? .white : coins[i].color)
                        }
                    }
                LineChart(coins: $coins)
                .frame(height: 200)
                .padding(.horizontal)
            }
        }
    }
}

struct LineChrtView_Previews: PreviewProvider {
    static var previews: some View {
        LineChrtView()
    }
}
