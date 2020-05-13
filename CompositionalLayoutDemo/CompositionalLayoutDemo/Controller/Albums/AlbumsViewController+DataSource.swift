//
//  AlbumsViewController+DataSource.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 10/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation
import UIKit

extension AlbumsViewController {
    
    //MARK: - Public methods
    
    /// Configures the data source
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource <AlbumSection, AlbumItem>(collectionView: albumsCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, albumItem: AlbumItem) -> UICollectionViewCell? in

            let sectionType = AlbumSection.allCases[indexPath.section]
            switch sectionType {
            case .featuredAlbums:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedAlbumCollectionViewCell.ReuseIdentifer, for: indexPath) as? FeaturedAlbumCollectionViewCell else {
                    return nil
                }

                cell.photoURL = albumItem.photos[0].url
                cell.title = albumItem.title
                cell.numberOfPhotos = albumItem.photos.count
                
                return cell

            case .sharedAlbums:
                guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: SharedAlbumCollectionViewCell.ReuseIdentifer, for: indexPath) as? SharedAlbumCollectionViewCell else {
                    return nil
                }

                cell.photoURL = albumItem.photos[0].url
                cell.title = albumItem.title
                
                return cell

            case .myAlbums:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyAlbumCollectionViewCell.ReuseIdentifer, for: indexPath) as? MyAlbumCollectionViewCell else {
                    return nil
                }

              cell.photoURL = albumItem.photos[0].url
              cell.title = albumItem.title
                
              return cell
            }
        }
        
        dataSource.supplementaryViewProvider = {(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in

            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.ReuseIdentifier,for: indexPath) as? HeaderCollectionReusableView else {
                return nil
            }
            
            supplementaryView.titleLabel.text = AlbumSection.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        
        let snapshot = initialSnapshot()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    //MARK: - Private methods
    
    /// Creates the snapshot for the data source
    /// - Returns: the snapshot for the initial state
    private func initialSnapshot() -> NSDiffableDataSourceSnapshot<AlbumSection, AlbumItem> {
        let allAlbums = albumsInBaseDirectory()
        let featuredAlbums = Array(albumsInBaseDirectory().prefix(allAlbums.count / 2))
        let sharedAlbums = Array(albumsInBaseDirectory().suffix(allAlbums.count / 2))

        var snapshot = NSDiffableDataSourceSnapshot<AlbumSection, AlbumItem>()
        
        snapshot.appendSections([AlbumSection.featuredAlbums])
        snapshot.appendItems(featuredAlbums)

        snapshot.appendSections([AlbumSection.sharedAlbums])
        snapshot.appendItems(sharedAlbums)

        snapshot.appendSections([AlbumSection.myAlbums])
        snapshot.appendItems(allAlbums)
        
        return snapshot
    }
    
    /// - Returns: all albums in the base directory
    private func albumsInBaseDirectory() -> [AlbumItem] {
        guard let baseURL = baseURL else {
            return []
        }
       
        return FileManager.default.albumsAtURL(baseURL)
    }
}
