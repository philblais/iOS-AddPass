//
//  Home.swift
//  AddPass
//
//  Created by Phil on 2022-08-16.
//

import SwiftUI

struct Home: View {
    @State var expandCards: Bool = false
    @State var currentCard: Card?
    @State var showDetailCard: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            Text("Wallet")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: expandCards ? .leading : .center)
                .overlay(alignment: .trailing) {
                    Button {
                        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7,
                                blendDuration: 0.7)) {
                            expandCards = false
                        }
                    } label: {
                        Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.blue, in: Circle())

                    }
                            .rotationEffect(.init(degrees: expandCards ? 45 : 0))
                            .offset(x: expandCards ? 10 : 15)
                            .opacity(expandCards ? 1 : 0)
                }.padding(.horizontal, 15)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(cards) { card in
                        CardView(card: card).onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)){
                                currentCard = card
                                showDetailCard = true
                            }
                        }
                    }
                }
                .overlay {
                    Rectangle().fill(.black.opacity(expandCards ? 0 : 0.01)).onTapGesture {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            expandCards = true
                        }
                    }
                }
                .padding(.top, expandCards ? 30 : 0)
            }
            
            .coordinateSpace(name: "SCROLL")
            .offset(y: expandCards ? 30 : 0)
            
            Button {
                
            } label: {
                Image (systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(.blue, in: Circle())
            }
            .rotationEffect(.init(degrees: expandCards ? 180 : 0))
            .scaleEffect(expandCards ? 0.01 : 1)
            .opacity(!expandCards ? 1 : 0)
            .frame(height: expandCards ? 0 : nil)
            .padding(.bottom, expandCards ? 0 : 30)
        }
        .padding([.horizontal, .top])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if let currentCard = currentCard, showDetailCard {
                DetailView(currentCard: currentCard, showDetailCard: $showDetailCard)
            }
        }
    }

    @ViewBuilder
    func CardView(card: Card) -> some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .named("SCROLL"))
            let offset = CGFloat(getIndex(Card: card) * (expandCards ? 10 : 70))
            ZStack(alignment: .bottomLeading) {

                Image(card.cardImage)
                        .resizable()
                        .scaledToFill()
                        .shadow(color: .gray, radius: 4, x: 1, y: 1)
                        .padding(5)

                VStack(alignment: .leading, spacing: 10) {
                    Text(card.name).fontWeight(.bold)

                    Text(customizedCardNumber(number: card.cardNumber))
                            .font(.callout)
                            .fontWeight(.bold)
                }
                        .padding()
                        .padding(.bottom, 10)
                        .foregroundColor(.black)

            }
                    .offset(y: expandCards ? offset : -rect.minY + offset)
        }
        .frame(width: .infinity, height: 235)
    }

    func getIndex(Card: Card) -> Int {
        return cards.firstIndex { currentCard in
            return currentCard.id == Card.id
        } ?? 0
    }

    
}

func customizedCardNumber(number: String) -> String {

        var newValue: String = ""
        let maxCount = number.count - 4

        number.enumerated().forEach { value in
            if value.offset >= maxCount {
                let string = String(value.element)
                newValue.append(contentsOf: string)
            } else {
                let string = String(value.element)
                if string == " " {
                    newValue.append(contentsOf: " ")
                } else {
                    newValue.append(contentsOf: "*")

                }
            }

        }
        return newValue
    }

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct DetailView: View {
    var currentCard: Card
    @Binding var showDetailCard: Bool
    var body: some View {
        VStack {
            CardView().frame(height: 200)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func CardView()-> some View {
        ZStack(alignment: .bottomLeading) {

            Image(currentCard.cardImage)
                    .resizable()
                    .scaledToFill()
                    .shadow(color: .gray, radius: 4, x: 1, y: 1)
                    .padding(5)

            VStack(alignment: .leading, spacing: 10) {
                Text(currentCard.name).fontWeight(.bold)

                Text(customizedCardNumber(number: currentCard.cardNumber))
                        .font(.callout)
                        .fontWeight(.bold)
            }
                    .padding()
                    .padding(.bottom, 10)
                    .foregroundColor(.black)

        }
    }
}
