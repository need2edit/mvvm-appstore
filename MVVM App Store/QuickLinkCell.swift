//
//  QuickLinkCell.swift
//  MVVM App Store
//
//  Created by Jake Young on 3/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit
import MVVMAppStoreModel

struct QuickLinkViewModel {
    let link: QuickLink
    var title: String { return link.title }
}

class QuickLinkCell: BaseCell {
    
    var viewModel: QuickLinkViewModel! { didSet { setupViews() } }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: UIFontWeightRegular)
        label.numberOfLines = 2
        return label
    }()
    
    override func setupViews() {
        
        addSubview(titleLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: titleLabel)
        addConstraintsWithFormat("V:|[v0]|", views: titleLabel)
        
        updateProperties()
    }
    
    func updateProperties() {
        titleLabel.text = viewModel.title
    }
}
