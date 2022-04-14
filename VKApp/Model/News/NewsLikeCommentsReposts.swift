//
//  NewsLikeCommentsReposts.swift
//  VKApp
//
//  Created by Никита Мошенцев on 09.04.2022.
//

import Foundation

struct NewsLikes {
    let likesCount: Int
}

extension NewsLikes: Codable {
    enum CodingKeys: String, CodingKey {
        case likesCount = "count"
    }
}


struct NewsComments {
    let commentsCount: Int
}

extension NewsComments: Codable {
    enum CodingKeys: String, CodingKey {
        case commentsCount = "count"
    }
}


struct NewsReposts {
    let repostsCount: Int
}

extension NewsReposts: Codable {
    enum CodingKeys: String, CodingKey {
        case repostsCount = "count"
    }
}

struct NewsViews {
    let viewsCount: Int
}

extension NewsViews: Codable {
    enum CodingKeys: String, CodingKey {
        case viewsCount = "count"
    }
}
