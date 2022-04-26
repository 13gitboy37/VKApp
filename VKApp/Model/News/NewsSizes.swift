//
//  NewsSizes.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsSizes {
    let photo: NewsImagesSizes?
}

extension NewsSizes: Codable {
    enum CodingKeys: String, CodingKey {
        case photo = "photo"
    }
}

