//
//  RealmSearchGroup.swift
//  VKApp
//
//  Created by Никита Мошенцев on 16.03.2022.
//

import Foundation
import RealmSwift

class RealmSearchGroup: Object {
    @Persisted(primaryKey: true) var id: Int = Int()
    @Persisted(indexed: true) var name: String = ""
    @Persisted var groupsPhoto: String = ""
}

extension RealmSearchGroup {
    convenience init(seatchGroupName: String, groups: GroupsItems) {
        self.init()
        self.id = groups.id
        self.name = groups.name
        self.groupsPhoto = groups.groupsPhoto
    }
}
