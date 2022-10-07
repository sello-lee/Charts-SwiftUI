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
                    Button(coins[0].name) {
                        coins[0].show = !coins[0].show
                    }
                    .padding(10)
                    .border(coins[0].color)
                    .background(coins[0].show ? coins[0].color : Color.white)
                    .foregroundColor(coins[0].show ? .white : coins[0].color)
                    Button(coins[1].name) {
                        coins[1].show = !coins[1].show
                    }
                    .padding(10)
                    .border(coins[1].color)
                    .background(coins[1].show ? coins[1].color : Color.white)
                    .foregroundColor(coins[1].show ? .white : coins[1].color)
                }
//                    HStack {
//                        ForEach(0..<coins.indices) { i in
//                            Button(coins[i].name) {
//                                coins[i].show.toggle()
//                            }
//                            .padding(10)
//                            .border(coins[i].color)
//                            .background(coins[i].show ? coins[i].color : Color.white)
//                            .foregroundColor(coins[i].show ? .white : coins[i].color)
//                        }
//                    }
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
