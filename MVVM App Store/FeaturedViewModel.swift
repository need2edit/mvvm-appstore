//
//  FeaturedViewModel.swift
//  MVVM App Store
//
//  Created by Jake Young on 3/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit
import MVVMAppStoreModel

struct FeaturedViewModel: ViewModel {
    
    var model: FeaturedModel
    var headerModel: PromotionsHeaderModel
    
    init() {
        
        let apps = AppStoreDataProvider.shared.freeApps()
        let promos = AppStoreDataProvider.shared.headerPromotions()
        let links = AppStoreDataProvider.shared.quicklinks()
        
        print("Found \(apps.count) apps in model.")
        
        let row = AppStoreSection.apps(title: "New apps we love", apps)
        let row2 = AppStoreSection.apps(title: "New gamses we love", apps)
        let row3 = AppStoreSection.apps(title: "Popular", apps)
        let row4 = AppStoreSection.links(title: "Quick Links", links)
        
        self.headerModel = PromotionsHeaderModel(items: promos)
        
        self.model = FeaturedModel(items: [row, row2, row3, row4])
        self.title = model.title
    }
    
    internal func numberOfItems(inSection section: Int) -> Int {
        return model.numberOfItems(inSection: section)
    }
    
    internal var numberOfSections: Int { return model.numberOfSections }
    
    internal var title: String
    
    func registerCells(in collectionView: UICollectionView?) {
        collectionView?.register(RowCell.self, forCellWithReuseIdentifier: "RowCell")
        collectionView?.register(QuickLinkCell.self, forCellWithReuseIdentifier: "QuickLinkCell")
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCell")
    }
    
    func viewModel(at indexPath: IndexPath, in collectionView: UICollectionView) -> RowViewModel {
        return RowViewModel(model: model.items[indexPath.section], itemWidth: 94.5, itemSpacing: 16.0)
    }
    
    func configureCell<Cell: UICollectionViewCell>(_ cell: Cell, at indexPath: IndexPath, with collectionView: UICollectionView) {
        if let cell = cell as? RowCell {
            cell.viewModel = viewModel(at: indexPath, in: collectionView)
        }
    }
    
    func sectionHeight(for indexPath: IndexPath) -> CGFloat {
        switch model.items[indexPath.section] {
            case .links:
                return 54.0 + CGFloat(model.items[indexPath.section].itemCount) * 44.0
            case .apps, .promotions:
                return 220.0
        }
    }
    
    func configureHeader<Cell: UICollectionReusableView>(_ header: Cell, at indexPath: IndexPath) {
        if let cell = header as? HeaderCell {
            cell.viewModel = HeaderCellViewModel(title: "Promotions", model: headerModel)
        }
    }
    
}
