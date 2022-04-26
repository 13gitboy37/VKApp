//
//  NewsItems.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsItems {
    let sourceID: Int
    let text: String?
    let attachments: [NewsSizes]?
    let likes: NewsLikes
    let comments: NewsComments
    let reposts: NewsReposts
    let views: NewsViews?
}

extension NewsItems: Codable {
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case text = "text"
        case attachments = "attachments"
        case likes = "likes"
        case comments = "comments"
        case reposts = "reposts"
        case views = "views"
    }
}
