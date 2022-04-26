//
//  UserResponse.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.02.2022.
//

import UIKit

struct UserResponse {
    let users: User
}

extension UserResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case users = "response"
    }
}

