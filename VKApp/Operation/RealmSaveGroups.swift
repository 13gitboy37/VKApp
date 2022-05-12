//
//  RealmSaveGroups.swift
//  VKApp
//
//  Created by Никита Мошенцев on 13.04.2022.
//

import Foundation
import RealmSwift

class RealmSaveGroups:Operation {
    
    var groups: [GroupsItems] = []
    
    init(realmGroups: [GroupsItems]) {
        self.groups = realmGroups
    }
    
    override func main(){
        guard let parseData = dependencies.first as? ParseDataOperation else { return }
        do {
            let realmGroups = parseData.outputData.map{ RealmGroup(groups: $0) }
            try RealmService.save(items: realmGroups)
        } catch {
            print("Error Realm")
        }
    }
    
}
