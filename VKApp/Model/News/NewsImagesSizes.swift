//
//  NewsImagesSizes.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsImagesSizes {
    let ownerID: Int
    let sizes: [NewsImages]
}

extension NewsImagesSizes: Codable {
    enum CodingKeys: String, CodingKey{
        case ownerID = "owner_id"
        case sizes = "sizes"
    }
}
