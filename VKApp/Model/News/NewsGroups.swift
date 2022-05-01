//
//  NewsGroups.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsGroups {
    let id: Int
    let name: String
    let photo: String
}

extension NewsGroups: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo = "photo_50"
    }
}
