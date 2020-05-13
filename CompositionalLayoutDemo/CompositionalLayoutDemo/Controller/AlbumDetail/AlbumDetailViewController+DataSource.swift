//
//  AlbumDetailViewController+DataSource.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 10/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation
import UIKit

extension AlbumDetailViewController {
    
    //MARK: - Public methods
    
    /// Configures the data source
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource <AlbumDetailSection, PhotoItem>(collectionView: albumDetailCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, detailItem: PhotoItem) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifer, for: indexPath) as? PhotoCollectionViewCell else {
                return nil
            }
            cell.photoURL = detailItem.url
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = {(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let badgeView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: SyncingBadgeCollectionReusableView.ReuseIdentifier, for: indexPath) as? SyncingBadgeCollectionReusableView else {
                return nil
            }
            
            return badgeView
        }
        
        let snapshot = initialSnapshot()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    //MARK: - Private methods
    
    /// Creates the snapshot for the data source
    /// - Returns: the snapshot for the initial state
    private func initialSnapshot() -> NSDiffableDataSourceSnapshot<AlbumDetailSection, PhotoItem> {
        var snapshot = NSDiffableDataSourceSnapshot<AlbumDetailSection, PhotoItem>()
        snapshot.appendSections([AlbumDetailSection.albumBody])
        
        let items = itemsForAlbum()
        snapshot.appendItems(items)
        
        return snapshot
    }
    
    /// - Returns: All items for the current album
    private func itemsForAlbum() -> [PhotoItem] {
        guard let albumURL = albumURL else {
            return []
        }
   
        return FileManager.default.photosAtURL(albumURL)
    }
}
