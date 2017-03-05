//
//  ViewModel.swift
//  MVVM App Store
//
//  Created by Jake Young on 3/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit
import MVVMAppStoreModel

protocol GridRepresentable { }

protocol Model {
    associatedtype A
    var items: [A] { get set }
    var numberOfItems: Int { get }
    func item(at index: Int) -> A
}

extension Model {
    func item(at index: Int) -> A { return items[index] }
    var numberOfItems: Int { return items.count }
}

protocol SectionsRepresentable {
    var numberOfSections: Int { get }
    func numberOfItems(inSection section: Int) -> Int
}

protocol ViewModel {
    
    associatedtype Item: Model
    var model: Item { get set }
    
    var title: String { get set }
    var numberOfSections: Int { get }
    func numberOfItems(inSection section: Int) -> Int
    
}

extension ViewModel {
    var numberOfSections: Int { return 1 }
    func numberOfItems(inSection section: Int) -> Int { return model.numberOfItems }
}
