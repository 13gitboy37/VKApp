//
//  NewsProfiles.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsProfiles {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: String
}

extension NewsProfiles: Codable {
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
    }
}
