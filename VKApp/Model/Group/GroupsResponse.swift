//
//  GroupsResponse.swift
//  VKApp
//
//  Created by Никита Мошенцев on 21.02.2022.
//

import UIKit

struct GroupsResponse {
    let groups: Groups
}

extension GroupsResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case groups = "response"
    }
}
