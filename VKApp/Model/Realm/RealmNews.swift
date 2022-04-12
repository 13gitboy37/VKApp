//
//  RealmNews.swift
//  VKApp
//
//  Created by Никита Мошенцев on 08.04.2022.
//



//
//import Foundation
//import RealmSwift
//
//class RealmNews: Object {
//    @Persisted(primaryKey: true) var id: Int = Int()
//    @Persisted(indexed: true) var name: String = ""
//    @Persisted var avaNewsPhoto: String = ""
//    @Persisted var text: String = ""
//    @Persisted var newsImages: List<RealmNewsPhoto>
//    @Persisted var likes: Int = Int()
//    @Persisted var reposts: Int = Int()
//    @Persisted var comments: Int = Int()
//    @Persisted var views: Int = Int()?
//}
//
//extension RealmNews {
//    convenience init(news: NewsItems, groupsNews: NewsGroups, profilesNews: NewsProfiles) {
//        self.init()
//        if news.sourceID > 0 {
//            self.id = profilesNews.id
//            self.name = profilesNews.lastName + " " + profilesNews.lastName
//            self.avaNewsPhoto = profilesNews.photo
//        } else {
//            self.id = groupsNews.id
//            self.name = groupsNews.name
//            self.avaNewsPhoto = groupsNews.photo
//        }
//        self.text = news.text
//        self.likes = news.likes.likesCount
//        self.comments = news.comments.commentsCount
//        self.reposts = news.reposts.repostsCount
//        self.views = news.views.viewsCount
//}
//}
