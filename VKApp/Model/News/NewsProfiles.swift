//
//  NewsProfiles.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsProfiles {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: String
}

extension NewsProfiles: Codable {
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
    }
}
 /*"profiles": [
  {
      "id": 102891,
      "first_name": "Ксения",
      "last_name": "Волчик",
      "can_access_closed": true,
      "is_closed": false,
      "sex": 1,
      "screen_name": "kesakko",
      "photo_50": "https://sun1-18.userapi.com/s/v1/if1/mJqGzkQa8E6zSEEAMwLLj4_mhljtozxmNvibOqDOqOmpUGoxoiFX9_4akrOxUZwHA8ysgA.jpg?size=50x50&quality=96&crop=457,8,1685,1685&ava=1",
      "photo_100": "https://sun1-18.userapi.com/s/v1/if1/EZvLh2o5ZPJCkKk9hLl4OUfLYF1voIq9l3PL_syNhBMpPLRmwYa-OSJyN3Trq7pL8CD7LA.jpg?size=100x100&quality=96&crop=457,8,1685,1685&ava=1",
      "online_info": {
          "visible": true,
          "last_seen": 1649481032,
          "is_online": false,
          "app_id": 2274003,
          "is_mobile": true
      },
      "online": 0
  },
*/
