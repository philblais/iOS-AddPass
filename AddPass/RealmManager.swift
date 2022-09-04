//
//  RealmManager.swift
//  AddPass
//
//  Created by Phil on 2022-09-03.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var cars: [Card] = []

    init(){
        openRealm()
        getCards()
    }

    func openRealm(){
        do {
            let config = Realm.Configuration(schemaVersion:1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm ()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }

    func addCard(title: String, cardNumber:String, cardImage:String){
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newCard = Card(value: ["title": title, "cardNumber": cardNumber, "cardImage": cardImage])
                    localRealm.add(newCard)
                    print("Added new card to Realm: \(newCard)" )
                }

            } catch {
                print("Error adding card to Realm: \(error)")
            }
        }
    }

    func getCards(){
        if let localRealm = localRealm {
            let allCards = localRealm.objects(Card.self)
            cards = []
            allCards.forEach { card in
                cards.append(card)
            }
        }
    }
    
    func getCardsCount() -> Int{
        if let localRealm = localRealm {
            return localRealm.objects(Card.self).count
        }
        return 0
    }

    func updateCard(id: ObjectId){
        if let localRealm = localRealm {
            do {
                let cardToUpdate = localRealm.objects(Card.self).filter(NSPredicate(format: "id == %@", id))
                guard !cardToUpdate.isEmpty else { return }
                try localRealm.write {
                    getCards()
                    print("Update card with id \(id)")
                }
            } catch {
                print("Error updating card \(id) to Realm \(error)")
            }
        }
    }

    func deleteCard (id:ObjectId) {
        if let localRealm = localRealm {
            do {
                let cardToDelete = localRealm.objects(Card.self).filter(NSPredicate(format: "id == %@", id))
                guard !cardToDelete.isEmpty else { return }
                try localRealm.write {
                    localRealm.delete(cardToDelete)
                    getCards()
                    print("Deleted card with id \(id)")
                }
            } catch {
                print("Error deleting card \(id) to Realm \(error)")
            }
        }
    }
}
