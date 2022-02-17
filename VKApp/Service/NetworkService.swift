//
//  NetworkService.swift
//  VKApp
//
//  Created by Никита Мошенцев on 17.02.2022.
//

import Foundation
import Alamofire

final class NetworkService {

    private var urlConstructorFriend: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        constructor.path = "/method/friends.get"
        return constructor
    }()


    func getFriends() {
    guard let host = urlConstructorFriend.url else { return }
    let paramaters : Parameters = [
        "access_token": UserSession.instance.token,
 //       "user_id": UserSession.instance.userID,
        "v": "5.131"
    ]
    AF.request(host,
               method: .get,
               parameters: paramaters)
        .responseJSON(completionHandler: { json in
            print(json)
        })
}
    private var urlConstructorGroup: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        constructor.path = "/method/groups.get"
        return constructor
    }()


    func getGroups() {
    guard let host = urlConstructorGroup.url else { return }
    let paramaters : Parameters = [
        "access_token": UserSession.instance.token,
 //       "user_id": UserSession.instance.userID,
        "v": "5.131"
    ]
    AF.request(host,
               method: .get,
               parameters: paramaters)
        .responseJSON(completionHandler: { json in
            print(json)
        })
}
    private var urlConstructorPhoto: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        constructor.path = "/method/photos.get"
        return constructor
    }()


    func getPhotos() {
    guard let host = urlConstructorPhoto.url else { return }
    let paramaters : Parameters = [
        "access_token": UserSession.instance.token,
 //       "user_id": UserSession.instance.userID,
        "v": "5.131",
        "album_id" : "profile",
        "rev" : 0
    ]
    AF.request(host,
               method: .get,
               parameters: paramaters)
        .responseJSON(completionHandler: { json in
            print(json)
        })
}
    private var urlConstructSearchGroup: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        constructor.path = "/method/groups.search"
        return constructor
    }()
    
    func getSearchGroups() {
        guard let host = urlConstructSearchGroup.url else { return }
        let parameters: Parameters = [
            "access_token": UserSession.instance.token,
            "v": "5.131",
            "q": "News",
            "sort": 6,
            "count": 10
        ]
        AF.request(host,
                   method: .get,
                   parameters: parameters)
            .responseJSON(completionHandler: { json in
                print(json)
            })
    }
}
