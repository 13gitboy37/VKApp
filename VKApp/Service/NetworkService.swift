//
//  NetworkService.swift
//  VKApp
//
//  Created by Никита Мошенцев on 17.02.2022.
//

import Foundation
import Alamofire

final class NetworkService {

    lazy var mySession = URLSession(configuration: configuration)
    let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        return config
    }()
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        return constructor
    }()

    func getFriends(completion: @escaping (Result<[UserItems],Error>) -> Void) {
            var constructor = self.urlConstructor
        constructor.path = "/method/friends.get"
        constructor.queryItems = [
            URLQueryItem(name: "access_token", value: "\(UserSession.instance.token)"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "fields", value: "photo_100")
        ]
    guard
        let url = constructor.url
    else { return }
            let task = self.mySession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(userResponse.users.items))
//                print(userResponse)
            } catch {
                completion(.failure(error))
            }
        }
            task.resume()
        }


    func getGroups(completion: @escaping (Result<[GroupsItems],Error>) -> Void) {
    urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: UserSession.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "photo_100")
        ]
    guard
        let url = urlConstructor.url
    else { return }
        let task = mySession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
                completion(.success(groupsResponse.groups.items))
          /*      let userResponse = try JSONDecoder().decode(
                    UserResponse.self,
                    from: data) */
    
                print(groupsResponse)
            } catch {
                completion(.failure(error))
            }
        }
            task.resume()
        }
    
    

    func getPhotos(ownerID: Int?, completion: @escaping (Result<[PhotosItems],Error>) -> Void) {
        var constructor = self.urlConstructor
    constructor.path = "/method/photos.get"
    constructor.queryItems = [
        URLQueryItem(name: "access_token", value: "\(UserSession.instance.token)"),
        URLQueryItem(name: "owner_id", value: "\(ownerID!)"),
        URLQueryItem(name: "v", value: "5.131"),
        URLQueryItem(name: "rev", value: "1"),
        URLQueryItem(name: "album_id", value: "profile")
    ]
guard
    let url = constructor.url
else { return }
        let task = self.mySession.dataTask(with: url) { data, response, error in
        if let response = response as? HTTPURLResponse {
            print(response.statusCode)
        }
        guard
            error == nil,
            let data = data
        else { return }
        do {
            let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: data)
            completion(.success(photosResponse.photos.items))
        } catch {
            completion(.failure(error))
        }
    }
        task.resume()
    }
    
    func getSearchGroups(searchText: String, completion: @escaping (Result<[GroupsItems],Error>) -> Void) {
    urlConstructor.path = "/method/groups.search"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: UserSession.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "sort", value: "6"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "q", value: searchText)
        ]
    guard
        let url = urlConstructor.url
    else { return }
        let task = mySession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
                completion(.success(groupsResponse.groups.items))
                print(groupsResponse)
            } catch {
                completion(.failure(error))
            }
        }
            task.resume()
        }
    
    
    func getNews (completion: @escaping (Result<[NewsItems], Error>) -> Void) {

        urlConstructorForNews()
    guard
        let url = urlConstructor.url
    else { return }
        let task = mySession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(newsResponse.news.items))
                print(newsResponse)
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
            task.resume()
        }
        
    func getNewsProfiles (completion: @escaping (Result<[NewsProfiles], Error>) -> Void) {
        urlConstructorForNews()
    guard
        let url = urlConstructor.url
    else { return }
        let task = mySession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(newsResponse.news.profiles))
                print(newsResponse)
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
            task.resume()
        }
    
    func getNewsGroups (completion: @escaping (Result<[NewsGroups], Error>) -> Void) {
        urlConstructorForNews()
    guard
        let url = urlConstructor.url
    else { return }
        let task = mySession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(newsResponse.news.groups))
                print(newsResponse)
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
            task.resume()
        }
        
    func urlConstructorForNews() {
        urlConstructor.path = "/method/newsfeed.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "access_token", value: UserSession.instance.token),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "filters", value: "post"),
                URLQueryItem(name: "max_photos", value: "9"),
                URLQueryItem(name: "count", value: "10")
            ]
    }
}
