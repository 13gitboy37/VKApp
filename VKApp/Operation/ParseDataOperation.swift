//
//  ParseDataOperation.swift
//  VKApp
//
//  Created by Никита Мошенцев on 13.04.2022.
//

import UIKit
import Alamofire

class ParseData: Operation {
    private(set) var outputData: [GroupsItems] = []
    private var decoder = JSONDecoder()
    

    
    override func main() {
        guard let getDataOperation = dependencies.first(where:{ $0 is GetDataOperation }) as? GetDataOperation,
              let data = getDataOperation.data else {
                    print("Data not loaded")
                    return
        }
        do {
            let groups = try decoder.decode(GroupsResponse.self , from: data)
            outputData = groups.groups.items
        } catch {
            print("Data to decode failed")
        }
        }
    }
