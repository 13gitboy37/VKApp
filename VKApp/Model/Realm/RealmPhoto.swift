//
//  RealmPhoto.swift
//  VKApp
//
//  Created by Никита Мошенцев on 16.03.2022.
//

import Foundation
import RealmSwift

class RealmPhoto: Object {
    @Persisted(indexed: true) var ownerID: Int = Int()
    @Persisted(primaryKey: true) var urlPhoto: String = ""
}

extension RealmPhoto {
    convenience init(ownerID: Int,
                     photos: PhotosItems) {
        self.init()
        self.ownerID = ownerID
        self.urlPhoto = photos.sizes.last!.urlPhoto
    }
}
