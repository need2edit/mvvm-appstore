//
//  RowCell.swift
//  MVVM App Store
//
//  Created by Jake Young on 3/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit
import MVVMAppStoreModel

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        assertionFailure("override in subclass")
    }
}

class RowCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var viewModel: RowViewModel! { didSet { setupViews() } }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: UIFontWeightRegular)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var dividerLine: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 11)
        button.sizeToFit()
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    override func setupViews() {
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.axis = .horizontal
        
        addSubview(stackView)
        addSubview(seeAllButton)
        addSubview(collectionView)
        addSubview(dividerLine)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(GridItemCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        addConstraintsWithFormat("H:|-15-[v0]-|", views: stackView)
        addConstraintsWithFormat("H:|-15-[v0]|", views: dividerLine)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("H:[v0]-|", views: seeAllButton)
        
        addConstraintsWithFormat("V:|-16-[v0]-10-[v1]-|", views: stackView, collectionView)
        addConstraintsWithFormat("V:[v0(0.5)]-7-|", views: dividerLine)
        
        seeAllButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        updateProperties()
    }
    
    func updateProperties() {
        
        if let viewModel = viewModel {
            titleLabel.text = viewModel.title
            seeAllButton.isHidden = !viewModel.isShowingShowAllButton
            (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection = viewModel.scrollingDirection
            collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(inSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GridItemCell
        
        
        let item = viewModel?.model.items()[indexPath.row]
        
        if let item = item as? App {
            cell.viewModel = GridItemViewModel(app: item)
        }
        
        if let item = item as? QuickLink {
            cell.viewModel = GridItemViewModel(link: item)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.itemAttributes(within: collectionView).spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    
    var attributesCache = [IndexPath: (size: CGSize, spacing: CGFloat)]()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let attributes = attributesCache[indexPath] {
            return attributes.size
        } else {
            attributesCache[indexPath] = viewModel.itemAttributes(within: collectionView)
            return attributesCache[indexPath]!.size
        }
        
    }
}
