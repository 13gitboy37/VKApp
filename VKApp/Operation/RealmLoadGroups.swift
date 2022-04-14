//
//  RealmLoadGroups.swift
//  VKApp
//
//  Created by Никита Мошенцев on 14.04.2022.
//

import UIKit
import RealmSwift

class RealmLoadGroups: Operation {
    var groups: Results<RealmGroup>?
    
   init(realmGroups: Results<RealmGroup>?) {
        self.groups = realmGroups
    }
    
    override func main() {
        guard let saveGroups = dependencies.first as? RealmSaveGroups else { return }
        do {
          groups = try RealmService.load(typeOf: RealmGroup.self)
        } catch {
            print("Can`t load Realm")
        }
    }
}
