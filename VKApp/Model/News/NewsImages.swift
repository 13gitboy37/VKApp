//
//  NewsAva.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsImages {
    let url: String
    let height: Int
}

extension NewsImages: Codable {
    enum CodingKeys: String, CodingKey{
        case url = "url"
        case height = "height"
    }
}
