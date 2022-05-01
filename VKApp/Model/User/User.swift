//
//  User.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.12.2021.
//

import UIKit

struct User {
    let items: [UserItems]
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}
