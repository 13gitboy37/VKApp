//
//  User.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.12.2021.
//

import UIKit

struct User {
    let items: [UserItems]
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}


/*
 "response": {
         "count": 172,
         "items": [
             {
                 "id": 3550329,
                 "first_name": "Александр",
                 "last_name": "Лосяков",
                 "can_access_closed": true,
                 "is_closed": false,
                 "photo_100": "https://sun1-97.userapi.com/s/v1/ig2/PhtAbFCUjFirsCJCrNbkV94ZMvKBJKFTF57xkSFOovzjHHlFPzCcglT1F7PrmH27PciK3sPP1FYXIMyQpBw9zzNk.jpg?size=100x100&quality=95&crop=108,109,681,681&ava=1",
                 "track_code": "402bbec5cGrea9fhPLSclYsAc1Je-2WGgmhnpcUWWRUgArEnhvUdAY1btuNrtZ2QufD4lJ-IHIWCAQI"
             },
 */
