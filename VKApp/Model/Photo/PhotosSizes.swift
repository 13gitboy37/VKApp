//
//  PhotosSizes.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.02.2022.
//

import UIKit

struct PhotosSizes {
    let urlPhoto: String
}

extension PhotosSizes: Codable {
    enum CodingKeys: String, CodingKey {
        case urlPhoto = "url"
    }
}
