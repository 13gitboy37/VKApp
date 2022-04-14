//
//  NewsGroups.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsGroups {
    let id: Int
    let name: String
    let photo: String
}

extension NewsGroups: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo = "photo_50"
    }
}

/*"groups": [
          {
              "id": 92543292,
              "name": "4x100 4x98 WHEELS CLUB",
              "screen_name": "wheelsclub_4x100",
              "is_closed": 0,
              "type": "page",
              "is_admin": 0,
              "is_member": 1,
              "is_advertiser": 0,
              "photo_50": "https://sun1-99.userapi.com/s/v1/if1/kVs4_JsIi9D9yLTB5NQUoCqZDxxvahsFyzeb0C47InKX3WXns4togNCO8Rmf8MBGDWufiQ.jpg?size=50x50&quality=96&crop=51,28,201,201&ava=1",
              "photo_100": "https://sun1-99.userapi.com/s/v1/if1/LqIyyBjJMga1R1V4ig1HF0u2N3KCVZWpoTJrHN9MU7OU_h7LzJLspbSVsn4C9Yc_oa2_CA.jpg?size=100x100&quality=96&crop=51,28,201,201&ava=1",
              "photo_200": "https://sun1-99.userapi.com/s/v1/if1/CsjTD2g6XpszI-jfFEFb9UkmSaQshVUodnz7W2cOdfPPLYjBs312Y6assE9bi7u3GNpkXA.jpg?size=200x200&quality=96&crop=51,28,201,201&ava=1"
          }, */
