//
//  Singleton.swift
//  VKApp
//
//  Created by Никита Мошенцев on 09.02.2022.
//

class Singleton {
    
    var token: String = ""
    var userID: Int = 0
    
   static let instance = Singleton()
    
    private init() {
        
    }
}
