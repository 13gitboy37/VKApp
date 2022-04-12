//
//  NewsResponse.swift
//  VKApp
//
//  Created by Никита Мошенцев on 04.04.2022.
//

import UIKit

struct NewsResponse {
    let news: News
}

extension NewsResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case news = "response"
    }
}
