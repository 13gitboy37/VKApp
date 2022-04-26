//
//  Groups.swift
//  VKApp
//
//  Created by Никита Мошенцев on 21.02.2022.
//


import UIKit

struct Groups {
    let items: [GroupsItems]
}

extension Groups: Codable {
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}
