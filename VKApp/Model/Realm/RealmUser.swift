//
//  RealmUser.swift
//  VKApp
//
//  Created by Никита Мошенцев on 14.03.2022.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @Persisted(primaryKey: true) var id: Int = Int()
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var userPhoto: String = ""
    @Persisted var fullName: String = ""
}

extension RealmUser {
    convenience init(users: UserItems) {
        self.init()
        self.id = users.id
        self.firstName = users.firstName
        self.lastName = users.lastName
        self.userPhoto = users.userPhoto
        self.fullName = lastName + " " + firstName
    }
}

extension RealmUser: Comparable {
        static func < (lhs: RealmUser, rhs: RealmUser) -> Bool { lhs.lastName < rhs.lastName }
}
