//
//  AlbumDetailViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Norbert Korosi on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    static let syncingBadgeKind = "syncingBadgeKind"
    
    var dataSource: UICollectionViewDiffableDataSource<AlbumDetailSection, AlbumDetailItem>!
    var albumDetailCollectionView: UICollectionView!
    
    var albumURL: URL?
    
    convenience init(withPhotosFromDirectory directoryURL: URL) {
        self.init()
        albumURL = directoryURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = albumURL?.lastPathComponent.displayNicely
        
        configureCollectionView()
        configureDataSource()
    }
    
    func configureCollectionView() {
        albumDetailCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(albumDetailCollectionView)
        albumDetailCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        albumDetailCollectionView.backgroundColor = .systemBackground
        albumDetailCollectionView.delegate = self
        albumDetailCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifer)
        albumDetailCollectionView.register(BadgeCollectionReusableView.self, forSupplementaryViewOfKind: AlbumDetailViewController.syncingBadgeKind, withReuseIdentifier: BadgeCollectionReusableView.reuseIdentifier)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource <AlbumDetailSection, AlbumDetailItem>(collectionView: albumDetailCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, detailItem: AlbumDetailItem) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifer, for: indexPath) as? PhotoCollectionViewCell else { fatalError("Could not create new cell") }
            cell.photoURL = detailItem.thumbnailURL
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = {(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            if let badgeView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: BadgeCollectionReusableView.reuseIdentifier, for: indexPath) as? BadgeCollectionReusableView {
                
                return badgeView
            } else {
                fatalError("Cannot create new supplementary")
            }
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        //Syncing badge view
        let syncingBadgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: -0.3, y: 0.3))
        let syncingBadge = NSCollectionLayoutSupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(20),heightDimension: .absolute(20)), elementKind: AlbumDetailViewController.syncingBadgeKind, containerAnchor: syncingBadgeAnchor)
        
        //Full width
        let fullItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: fullItemSize, supplementaryItems: [syncingBadge])
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        //Main
        let mainItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalHeight(1.0))
        let mainPhotoItem = NSCollectionLayoutItem(layoutSize: mainItemSize)
        mainPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        //Pair
        let pairItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5))
        let pairPhotoItem = NSCollectionLayoutItem(layoutSize: pairItemSize)
        pairPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        //Pair Vertical Group
        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: pairPhotoItem, count: 2)
        
        //Main with right vertical group
        let mainWithVerticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(4/9))
        let mainWithRightVerticalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainWithVerticalGroupSize, subitems: [mainPhotoItem, verticalGroup])
        
        //Triple Item
        let tripleItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0))
        let triplePhotoItem = NSCollectionLayoutItem(layoutSize: tripleItemSize)
        triplePhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        //Triple Group
        let tripleGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/9))
        let tripleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: tripleGroupSize, subitem: triplePhotoItem, count: 3)
        
        //Main with left vertical group
        let mainWithLeftVerticalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainWithVerticalGroupSize, subitems: [verticalGroup, mainPhotoItem])
        
        //Final group
        let overallGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(16/9))
        let overallGroup = NSCollectionLayoutGroup.vertical(layoutSize: overallGroupSize, subitems: [fullPhotoItem, mainWithRightVerticalGroup, tripleGroup, mainWithLeftVerticalGroup])

        let section = NSCollectionLayoutSection(group: overallGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<AlbumDetailSection, AlbumDetailItem> {
        var snapshot = NSDiffableDataSourceSnapshot<AlbumDetailSection, AlbumDetailItem>()
        snapshot.appendSections([AlbumDetailSection.albumBody])
        let items = itemsForAlbum()
        snapshot.appendItems(items)
        
        return snapshot
    }
    
    func itemsForAlbum() -> [AlbumDetailItem] {
        guard let albumURL = albumURL else { return [] }
        let fileManager = FileManager.default
        do {
            return try fileManager.albumDetailItemsAtURL(albumURL)
        } catch {
            print(error)
            return []
        }
    }
}

extension AlbumDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let photoDetailVC = PhotoViewController(photoURL: item.photoURL)
        
        navigationController?.pushViewController(photoDetailVC, animated: true)
    }
}
