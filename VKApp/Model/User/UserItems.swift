//
//  UserItems.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.02.2022.
//

import UIKit


struct UserItems {
    let firstName: String
    let lastName: String
    let userPhoto: String
    let id: Int
    var fullName: String {lastName + " " + firstName}
}

extension UserItems: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userPhoto = "photo_100"
        case id = "id"
    }
}

extension UserItems: Comparable {
        static func < (lhs: UserItems, rhs: UserItems) -> Bool { lhs.lastName < rhs.lastName }
}
