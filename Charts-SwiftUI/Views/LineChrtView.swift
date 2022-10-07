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
    private var coins = Coin.allCoins

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
                    ForEach(0..<coins.count) { i in
                        Button(coins[i].name) {
                            guard let dic = buttonDic[coins[i].name] else {
                                buttonDic[coins[i].name] = true
                                return
                            }
                            buttonDic[coins[i].name] = !dic
//                                buttonDic[coin.name] = true
                            print("hi")
                        }
                        .padding(10)
                        .border(coins[i].color)
                        .background(buttonDic[coins[i].name] ?? false ? coins[i].color : Color.white)
                        .foregroundColor(buttonDic[coins[i].name] ?? false  ? .white : coins[i].color)
                    }
                }
//                    LineChart(
//                        coins: coins,
//                        buttonDic: $buttonDic
//                    )
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
