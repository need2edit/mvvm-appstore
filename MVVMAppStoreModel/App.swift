//
//  App.swift
//  MVVM App Store
//
//  Created by Jake Young on 3/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation

public struct App {
    
    public let identifier: Int
    public let name: String
    public let category: Category

}

extension App {
    public init(json: JSONDictionary) throws {
        guard let im_name = json["im:name"] as? JSONDictionary, let name = im_name["label"] as? String, let categoryInfo = json["category"] as? JSONDictionary else { throw JSONError.emptyValue("No name for app.") }

        let category = try Category(json: categoryInfo)
        
        self.init(identifier: 123, name: name, category: category)
    }
}
