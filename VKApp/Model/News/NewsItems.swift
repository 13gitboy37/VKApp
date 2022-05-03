//
//  NewsItems.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//

import UIKit

struct NewsItems {
    let sourceID: Int
    var creatorName: String?
    var avatarURL: String?
    let date: Double
    let text: String?
    let attachments: [NewsSizes]?
    let likes: NewsLikes
    let comments: NewsComments
    let reposts: NewsReposts
    let views: NewsViews?
    
    var photosURL: [String]? {
        get {
            let photosURL = attachments?.compactMap{ $0.photo?.sizes.last?.url }
            return photosURL
        }
    }
    
    var aspectRatio: CGFloat {
        let aspectRatio = attachments?.compactMap{ $0.photo?.sizes.last?.aspectRatio }.last
        return aspectRatio ?? 1
    }
}

extension NewsItems: Codable {
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case creatorName
        case avatarURL
        case date = "date"
        case text = "text"
        case attachments = "attachments"
        case likes = "likes"
        case comments = "comments"
        case reposts = "reposts"
        case views = "views"
    }
    
    func getStringDate() -> String {
        let dateFormatter = DateFormatterVK()
        return dateFormatter.convertDate(timeIntervalSince1970: date)
    }
    
    class DateFormatterVK {
        let dateFormatter = DateFormatter()
        
        func convertDate(timeIntervalSince1970: Double) -> String {
            dateFormatter.dateFormat = "MM-dd-yyyy HH.mm"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let date = Date(timeIntervalSince1970: timeIntervalSince1970)
            return dateFormatter.string(from: date)
        }
    }
}
