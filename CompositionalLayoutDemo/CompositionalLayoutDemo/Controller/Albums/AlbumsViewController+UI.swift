//
//  AlbumsViewController+UI.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 10/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation
import UIKit

extension AlbumsViewController {
    
    //MARK: - Public methods
    
    /// Configures the UI
    func configureUI() {
        navigationItem.title = "Your Albums"
        
        configureCollectionView()
    }

    //MARK: - Private methods
    
    /// Configures the collection view
    private func configureCollectionView() {
        let layout = generateLayout()
        albumsCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        albumsCollectionView.delegate = self
        
        albumsCollectionView.backgroundColor = .systemBackground
        albumsCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        albumsCollectionView.register(MyAlbumCollectionViewCell.self, forCellWithReuseIdentifier: MyAlbumCollectionViewCell.ReuseIdentifer)
        albumsCollectionView.register(FeaturedAlbumCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedAlbumCollectionViewCell.ReuseIdentifer)
        albumsCollectionView.register(SharedAlbumCollectionViewCell.self, forCellWithReuseIdentifier: SharedAlbumCollectionViewCell.ReuseIdentifer)
        albumsCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: SectionHeaderElementKind, withReuseIdentifier: HeaderCollectionReusableView.ReuseIdentifier)
        
        view.addSubview(albumsCollectionView)
    }
    
    /// Generate the layout
    /// - Returns: the layout for collection view
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            
            let sectionLayoutKind = AlbumSection.allCases[sectionIndex]
            
            switch sectionLayoutKind {
            case .featuredAlbums:
                return self.generateFeaturedAlbumsLayout(isWide: isWideView)
            case .sharedAlbums:
                return self.generateSharedlbumsLayout(isWide: isWideView)
            case .myAlbums:
                return self.generateMyAlbumsLayout(isWide: isWideView)
            }
        }
        
        return layout
    }
    
    /// Generate the layout for featured albums
    /// - Parameter isWide: parameter to check screen size
    /// - Returns: the section for featured albums
    private func generateFeaturedAlbumsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2 / 3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupFractionalWidth = isWide ? 0.475 : 0.95
        let groupFractionalHeight: Float = isWide ? 1 / 3 : 2 / 3
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)), heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderElementKind, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
    
    /// Generate the layout for shared albums
    /// - Returns: the section for shared albums
    private func generateSharedlbumsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let widthDimension = isWide ? 175 : 140
        let heightDimension = isWide ? 232 : 186
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(CGFloat(widthDimension)), heightDimension: .absolute(CGFloat(heightDimension)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderElementKind, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
    
    /// Generate the layout for my albums
    /// - Parameter isWide: parameter to check screen size
    /// - Returns: the section for my albums
    private func generateMyAlbumsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupHeight = NSCollectionLayoutDimension.fractionalWidth(isWide ? 0.25 : 0.5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWide ? 4 : 2)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderElementKind, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
}
