//
//  AlbumDetailViewController+UI.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 10/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation
import UIKit

extension AlbumDetailViewController {
    
    //MARK: - Public methods
    
    /// Configures the UI
    func configureUI() {
        navigationItem.title = albumURL?.lastPathComponent
        
        configureCollectionView()
    }
    
    //MARK: - Private methods
    
    /// Configures the collection view
    private func configureCollectionView() {
        let layout = generateLayout()
        albumDetailCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        albumDetailCollectionView.delegate = self
        
        albumDetailCollectionView.backgroundColor = .systemBackground
        albumDetailCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        albumDetailCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifer)
        albumDetailCollectionView.register(SyncingBadgeCollectionReusableView.self, forSupplementaryViewOfKind: SyncingBadgeKind, withReuseIdentifier: SyncingBadgeCollectionReusableView.ReuseIdentifier)
        
        view.addSubview(albumDetailCollectionView)
    }
    
    /// Generate the layout
    /// - Returns: the layout for collection view
    private func generateLayout() -> UICollectionViewLayout {
        //Syncing badge view
        let syncingBadgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: -0.3, y: 0.3))
        let syncingBadge = NSCollectionLayoutSupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(20),heightDimension: .absolute(20)), elementKind: SyncingBadgeKind, containerAnchor: syncingBadgeAnchor)
        
        //Full width
        let fullItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2 / 3))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: fullItemSize, supplementaryItems: [syncingBadge])
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        //Main
        let mainItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2 / 3), heightDimension: .fractionalHeight(1.0))
        let mainPhotoItem = NSCollectionLayoutItem(layoutSize: mainItemSize)
        mainPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        //Pair
        let pairItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let pairPhotoItem = NSCollectionLayoutItem(layoutSize: pairItemSize)
        pairPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        //Pair Vertical Group
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalHeight(1.0))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: pairPhotoItem, count: 2)
        
        //Main with right vertical group
        let mainWithVerticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(4 / 9))
        let mainWithRightVerticalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainWithVerticalGroupSize, subitems: [mainPhotoItem, verticalGroup])
        
        //Triple Item
        let tripleItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalHeight(1.0))
        let triplePhotoItem = NSCollectionLayoutItem(layoutSize: tripleItemSize)
        triplePhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        //Triple Group
        let tripleGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2 / 9))
        let tripleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: tripleGroupSize, subitem: triplePhotoItem, count: 3)
        
        //Main with left vertical group
        let mainWithLeftVerticalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainWithVerticalGroupSize, subitems: [verticalGroup, mainPhotoItem])
        
        //Final group
        let overallGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(16 / 9))
        let overallGroup = NSCollectionLayoutGroup.vertical(layoutSize: overallGroupSize, subitems: [fullPhotoItem, mainWithRightVerticalGroup, tripleGroup, mainWithLeftVerticalGroup])

        let section = NSCollectionLayoutSection(group: overallGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
