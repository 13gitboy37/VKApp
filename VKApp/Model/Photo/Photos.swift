//
//  Photos.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.02.2022.
//

import UIKit

struct Photos {
    let items: [PhotosItems]
}

extension Photos: Codable {
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}
