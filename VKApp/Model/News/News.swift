//
//  News.swift
//  VKApp
//
//  Created by Никита Мошенцев on 02.04.2022.
//

import UIKit

struct NewsModel {
    let avaNews: String
    let nameGroupNews: String
    let textNews: String
    let imageNews: [String]?
    let numOfNews: Int
}

struct News {
    let items: [NewsItems]
    let groups: [NewsGroups]
    let profiles: [NewsProfiles]
}

extension News: Codable {
    enum CodingKeys: String, CodingKey {
            case items = "items"
            case groups = "groups"
            case profiles = "profiles"
    }
}
