//
//  RealmNewsPhoto.swift
//  VKApp
//
//  Created by Никита Мошенцев on 09.04.2022.
//

import Foundation
import RealmSwift

class RealmNewsPhoto: Object {
    @Persisted(indexed: true) var ownerNewsID: Int = Int()
    @Persisted(primaryKey: true) var urlNewsPhoto: String = ""
}

extension RealmNewsPhoto {
    convenience init(ownerNewsID: Int, urlNewsPhoto: NewsItems) {
        self.init()
        self.ownerNewsID = ownerNewsID
        self.urlNewsPhoto = urlNewsPhoto.attachments?.first?.photo?.sizes.last?.url ?? ""
    }
}
