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

/*
 "response": {
         "count": 4,
         "items": [
             {
                 "album_id": -6,
                 "date": 1532966775,
                 "id": 456240330,
                 "owner_id": 10756268,
                 "lat": 55.764016,
                 "long": 37.576099,
                 "post_id": 6368,
                 "sizes": [
                     {
                         "height": 130,
                         "url": "https://sun9-81.userapi.com/impf/hcOPRAMbQLkbyhoWSPxKp_Cm4QiKqDNSFG5EXQ/V-v7Ae4iXso.jpg?size=97x130&quality=96&sign=61820a86c22d6e78f39dac71f20ecd8a&c_uniq_tag=PhSU_y6l80hjT57S5bkjRa9aVlLQ5BUxsixsSxdf0f0&type=album",
                         "type": "m",
                         "width": 97
                     },
 */
