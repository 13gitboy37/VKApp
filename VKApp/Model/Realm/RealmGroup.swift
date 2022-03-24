//
//  RealmGroup.swift
//  VKApp
//
//  Created by Никита Мошенцев on 15.03.2022.
//

import Foundation
import RealmSwift

class RealmGroup: Object {
    @Persisted(primaryKey: true) var id: Int = Int()
    @Persisted var name: String = ""
    @Persisted var groupsPhoto: String = ""
}

extension RealmGroup {
    convenience init(groups: GroupsItems) {
        self.init()
        self.id = groups.id
        self.name = groups.name
        self.groupsPhoto = groups.groupsPhoto
    }
    
    func toAnyObject() -> [String: Any] {
        [
            "groupName" : name,
            "groupsPhoto" : groupsPhoto
        ]
    }

}
