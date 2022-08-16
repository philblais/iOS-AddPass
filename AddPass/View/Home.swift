//
//  Home.swift
//  AddPass
//
//  Created by Phil on 2022-08-16.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            Text("Wallet").font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(cards) { card in

                        CardView(card: card)
                    }
                }
            }
        }
                .padding([.horizontal, .top])
    }

    @ViewBuilder
    func CardView(card: Card) -> some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottomLeading) {
                Image(card.cardImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading, spacing: 10) {
                    Text(card.name)
                            .fontWeight(.bold)
                    Text(card.cardNumber).font(.callout)
                            .fontWeight(.bold)
                }
               .padding()
               .padding(.bottom, 10)
            }
        }
        .frame(height: 200)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
