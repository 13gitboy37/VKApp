//
//  PhotosResponse.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.02.2022.
//

import UIKit

struct PhotosResponse {
    let photos: Photos
}

extension PhotosResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case photos = "response"
    }
}
