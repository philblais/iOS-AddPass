//
//  Card.swift
//  AddPass
//
//  Created by Phil on 2022-08-16.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cardNumber:String
    var cardImage: String
}

var cards : [Card] = [
    Card(name: "Card 1", cardNumber: "1234 1234 1243 1243", cardImage: "default-card"),
    Card(name: "Card 2", cardNumber: "1234 1234 1243 1243", cardImage: "default-card"),
    Card(name: "Card 3", cardNumber: "1234 1234 1243 1243", cardImage: "default-card"),
]


