//
//  GroupsItems.swift
//  VKApp
//
//  Created by Никита Мошенцев on 21.02.2022.
//

import UIKit

struct GroupsItems {
    let id: Int
    let name: String
    let groupsPhoto: String
}

extension GroupsItems: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case groupsPhoto = "photo_100"
    }
}
