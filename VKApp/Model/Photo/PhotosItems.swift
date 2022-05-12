//
//  PhotosItems.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.02.2022.
//

import UIKit

struct PhotosItems {
    let ownerID: Int
    let sizes: [PhotosSizes]
}

extension PhotosItems: Codable {
    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case sizes = "sizes"
    }
}
