//
//  GroupsItems.swift
//  VKApp
//
//  Created by Никита Мошенцев on 21.02.2022.
//

import UIKit

struct GroupsItems {
    let name: String
    let groupsPhoto: String
}

extension GroupsItems: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case groupsPhoto = "photo_100"
    }
}

/*"response": {
    "count": 174,
    "items": [
        {
            "id": 23148107,
            "name": "MDK",
            "screen_name": "mudachyo",
            "is_closed": 0,
            "type": "page",
            "is_admin": 0,
            "is_member": 1,
            "is_advertiser": 0,
            "photo_100": "https://sun1-28.userapi.com/s/v1/if1/zGji0ZR7Zmunww6r7TaHwL8T8WZWEby68NY6xPLHturhSRDgm9oXrkqf7tJdAt1KuOUb_t24.jpg?size=100x100&quality=96&crop=143,406,326,326&ava=1"
        }, */

/*{
    "response": {
        "count": 26141,
        "items": [
            {
                "id": 28639294,
                "name": "Футбол | News 24",
                "screen_name": "football_news",
                "is_closed": 0,
                "type": "page",
                "is_admin": 0,
                "is_member": 0,
                "is_advertiser": 0,
                "photo_50": "https://sun1-54.userapi.com/s/v1/ig2/wUFgikgGyi2KtuEnteyUUSyTXfGediUVE-xhKWZXhVd1tOJkSAJ-y3HaF1ZmpxF5m1sT1eWtyknmdiDcRnjMAa5y.jpg?size=50x50&quality=96&crop=32,27,1037,1037&ava=1",
                "photo_100": "https://sun1-54.userapi.com/s/v1/ig2/5HKYGZ1ncckCKt-MVhbAIwPSi1P_tRfnI0X1IbOXr6olew2LhzyANTy03Jt1ImJlRsSGrEMdJFezkwCKwcSYlvlV.jpg?size=100x100&quality=96&crop=32,27,1037,1037&ava=1",
                "photo_200": "https://sun1-54.userapi.com/s/v1/ig2/ckyyPPPlq3Bg9Hgr36y5juk4GqLVJO_jHEuS8W63FGdwEZ98N-y1id6I3vWYzE3c49Rzc7aOHEXroHYl_nJtvSBd.jpg?size=200x200&quality=96&crop=32,27,1037,1037&ava=1"
            }, */
