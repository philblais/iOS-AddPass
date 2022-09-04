//
//  Card.swift
//  AddPass
//
//  Created by Phil on 2022-08-16.
//

import SwiftUI
import RealmSwift

class Card: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var cardNumber = ""
    @Persisted var cardImage = ""
}

var cards : [Card] = [
            Card(value: ["name": "Card 1", "cardNumber": "1234 1234 1234 1234", "cardImage": "default-card"]),
            Card(value: ["name": "Card 2", "cardNumber": "1234 1234 1234 1234", "cardImage": "default-card"]),
            Card(value: ["name": "Card 3", "cardNumber": "1234 1234 1234 1234", "cardImage": "default-card"])
        ]