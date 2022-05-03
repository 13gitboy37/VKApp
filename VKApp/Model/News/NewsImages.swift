//
//  NewsAva.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsImages {
    let url: String
    let height: Int?
    let width: Int?
    
    var aspectRatio: CGFloat { return CGFloat (height ?? 1)/CGFloat(width ?? 1) }
}

extension NewsImages: Codable {
    enum CodingKeys: String, CodingKey{
        case url = "url"
        case height = "height"
        case width = "width"
    }
}
