//
//  ParseDataOperation.swift
//  VKApp
//
//  Created by Никита Мошенцев on 13.04.2022.
//

import Foundation
import Alamofire

class ParseDataOperation: AsyncOperation {
    private(set) var outputData = [GroupsItems]()
    private var decoder = JSONDecoder()
    

    
    override func main() {
        guard let getDataOperation = dependencies.first(where: { $0 is GetDataOperation}) as? GetDataOperation,
              let data = getDataOperation.data else {
                    print("Data not loaded")
                    return
        }
        do {
            let responseGroups = try decoder.decode(GroupsResponse.self , from: data)
            outputData = responseGroups.groups.items
        } catch {
            print("Data to decode failed")
        }
        self.state = .finished
        }
    }
