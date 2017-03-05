//
//  RowViewModel.swift
//  MVVM App Store
//
//  Created by Jake Young on 3/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation
import UIKit

struct RowViewModel {
    
    var title: String? { return model.title }
    var seeAllTitle: String = "See All"
    var itemWidth: CGFloat
    var itemSpacing: CGFloat
    var isShowingShowAllButton: Bool
    var scrollingDirection: UICollectionViewScrollDirection
    var sectionInsets: UIEdgeInsets
    
    let model: AppStoreSection
    
    init(model: AppStoreSection, itemWidth: CGFloat, itemSpacing: CGFloat) {
        self.model = model
        self.itemWidth = itemWidth
        self.itemSpacing = itemSpacing
        
        self.sectionInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        switch model {
            case .links:
                self.isShowingShowAllButton = false
                self.scrollingDirection = .vertical
            default:
                self.isShowingShowAllButton = true
                self.scrollingDirection = .horizontal
        }
    }
    
    func configure(cell: RowCell, at indexPath: IndexPath) {
        cell.backgroundColor = .green
    }
    
    func numberOfItems(inSection: Int) -> Int {
        return model.itemCount
    }
    
    var preferredColumns: CGFloat {
        return UIDevice.current.is_iPad ? 3 : 1
    }
    
    func itemAttributes(within collectionView: UICollectionView) -> (size: CGSize, spacing: CGFloat) {
        var width: CGFloat
        var height: CGFloat
        var spacing: CGFloat
        
        let availableWidth = collectionView.frame.width - sectionInsets.left - sectionInsets.right
        
        switch model {
        case .apps:
            width = 94.5
            spacing = 16.0
            height = collectionView.frame.height
        case .promotions:
            width = CGFloat((94.5 * 2) + 16.0)
            spacing = 16.0
            height = collectionView.frame.height
        case .links:
            spacing = 0.0
            width = CGFloat(availableWidth / preferredColumns) - CGFloat(model.itemCount) * spacing
            height = 44.0
        }
        
        return (CGSize(width: width, height: height), spacing)
    }
}
