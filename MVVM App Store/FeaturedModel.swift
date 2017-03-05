//
//  FeaturedModel.swift
//  MVVM App Store
//
//  Created by Jake Young on 3/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation
import MVVMAppStoreModel

protocol Row {
    var title: String { get }
}

enum AppStoreSection {
    case apps(title: String, [App])
    case promotions(title: String?, [Promotion])
    case links(title: String?, [QuickLink])
    
    var title: String? {
        switch self {
        case .apps(title: let title, _): return title
        case .promotions(title: let title, _), .links(title: let title, _): return title
        }
    }
    
    var itemCount: Int { return items().count }
    
    func items() -> [Any] {
        switch self {
            case .apps(title: _, let items): return items
            case .promotions(title: _, let items): return items
            case .links(title: _, let items): return items
        }
    }
}

struct FeaturedModel: Model, SectionsRepresentable {
    
    typealias A = AppStoreSection
    internal var items: [AppStoreSection]
    
    let title: String = "Featured"
    
    var numberOfSections: Int { return numberOfItems }
    func numberOfItems(inSection section: Int) -> Int {
        return items[section].itemCount
    }
}
