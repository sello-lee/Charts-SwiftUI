//
//  TwoView.swift
//  Charts-SwiftUI
//
//  Created by sello on 07/10/2022.
//

import SwiftUI
import Charts

struct FeatureChartView: View {
    @State private var selectedChart = 0

    @State var buttonDic: [String:Bool] = [:]
    private var coins = Coin.allCoins

    var body: some View {
        VStack(spacing: 20) {
            Picker(selection: $selectedChart, label: Text("Chart")) {
                Text("Bar chart").tag(0)
                Text("Line chart").tag(1)
            }
            .pickerStyle(.segmented)
            if selectedChart == 0 {
                VStack {
                    Text("총 자산 추이")
                        .font(.largeTitle)
                        .bold()
                    Text("지난달 보다 +3,000,000원 늘었어요")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .bold()
                    BarChart(entries: Money.moneysForHalf(money: Money.allMoney))
                    .frame(height: 300)
                }
            } else {
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
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }

}

struct FeatureChartView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureChartView()
    }
}
