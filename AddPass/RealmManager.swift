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
    
    func openRealm(){
        do {
            let config = Realm.Configuration(schemaVersion:1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm ()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
}
