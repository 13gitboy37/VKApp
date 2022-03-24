//
//  FirebaseFriends.swift
//  VKApp
//
//  Created by Никита Мошенцев on 23.03.2022.
//

import Foundation
import Firebase

final class FirebaseFriend {
    let fullName: String
    let reference: DatabaseReference?
    
    init(fullName: String) {
        self.fullName = fullName
        self.reference = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let fullName = value["fullName"] as? String
        else { return nil }
        self.reference = snapshot.ref
        self.fullName = fullName
    }
    
    func toAnyObject() -> [String: Any] {
        ["fullName": fullName]
    }
}
