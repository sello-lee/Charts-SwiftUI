//
//  LineChrtView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import SwiftUI
import Charts

struct LineChrtView: View {
    @State var klayButton: Bool = true
    @State var scnrButton: Bool = true
    @State var maticButton: Bool = true

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
                    Button("KLAY") {
                        klayButton.toggle()
                    }
                    .padding(10)
                    .background(klayButton ? Color.pink : Color.white)
                    .foregroundColor(klayButton ? .white : .pink)
                    .border(Color.pink)
                    Button("SCNR") {
                        scnrButton.toggle()
                    }
                    .padding(10)
                    .background(scnrButton ? Color.green : Color.white)
                    .foregroundColor(scnrButton ? .white : .green)
                    .border(Color.green)
                    Button("MATIC") {
                        maticButton.toggle()
                    }
                    .padding(10)
                    .background(maticButton ? Color.purple : Color.white)
                    .foregroundColor(maticButton ? .white : .purple)
                    .border(Color.purple)
                }
                LineChart(
                    klay: Coin.coinsForHalf(coins: Coin.allCoins, coinType: .KLAY),
                    scnr: Coin.coinsForHalf(coins: Coin.allCoins, coinType: .SCNR),
                    matic: Coin.coinsForHalf(coins: Coin.allCoins, coinType: .MATIC),
                    klayButton: $klayButton,
                    scnrButton: $scnrButton,
                    maticButton: $maticButton
                )
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
