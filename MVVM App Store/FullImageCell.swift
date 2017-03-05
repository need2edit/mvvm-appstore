//
//  FullImageCell.swift
//  MVVM App Store
//
//  Created by Jake Young on 3/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

struct FullImageViewModel {
    let tagline: String?
    let image: UIImage?
}

class FullImageCell: UICollectionViewCell {
    
    var viewModel: FullImageViewModel! { didSet { setupViews() } }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: UIFontWeightMedium)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    lazy var titleBackgroundView: GradientView = {
        let view = GradientView()
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    func setupViews() {
        addSubview(imageView)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views: imageView)
        
        addSubview(titleBackgroundView)
        addConstraintsWithFormat("H:|[v0]|", views: titleBackgroundView)
        
        addSubview(titleLabel)
        addConstraintsWithFormat("V:[v0]-4-|", views: titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 1.0).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.44).isActive = true
        
        titleBackgroundView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.40).isActive = true
        titleBackgroundView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 1.0).isActive = true
        
        updateProperties()
    }
    
    func updateProperties() {
        imageView.image = viewModel?.image
        titleLabel.text = viewModel?.tagline
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
