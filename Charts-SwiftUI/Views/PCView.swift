//
//  PCView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//

import SwiftUI
import Charts

struct PCView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("이번 달 나의 코인 평가 금액")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .bold()
                Text("4,500,000원")
                    .font(.largeTitle)
                    .bold()
                Divider()
                PieChart(entries: Token.tokensForHalf(tokens: Token.allTokens), total: Token.getTotal())
                .frame(height: 400)
                Divider()
                ForEach(Token.allTokens.indices) { index in
                    let token = Token.allTokens[index]
                    HStack {
                        if #available(iOS 15.0, *) {
                            Circle()
                                .frame(width: 20)
                                .foregroundColor(Color(uiColor: token.color))
                            Text(token.label)
                                .bold()
                                .font(.title)
                            Text("\((token.value / Token.getTotal()).formatted(.percent))")
                                .bold()
                                .font(.title)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(token.value.formatted(.number))원")
                                .font(.title)
                        } else {

                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct PCView_Previews: PreviewProvider {
    static var previews: some View {
        PCView()
    }
}
