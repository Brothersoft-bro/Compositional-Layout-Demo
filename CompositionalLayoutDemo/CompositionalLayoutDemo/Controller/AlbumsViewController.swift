//
//  AlbumsViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Norbert Korosi on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    static let sectionHeaderElementKind = "SectionHeaderElementKind"
    
    var dataSource: UICollectionViewDiffableDataSource<AlbumSection, AlbumItem>!
    var albumsCollectionView: UICollectionView! = nil

    var baseURL: URL?

    convenience init(withAlbumsFromDirectory directory: URL) {
        self.init()
        baseURL = directory
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Your Albums"
        configureCollectionView()
        configureDataSource()
    }
}

extension AlbumsViewController {
    func configureCollectionView() {
        albumsCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(albumsCollectionView)
        albumsCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        albumsCollectionView.backgroundColor = .systemBackground
        albumsCollectionView.delegate = self
        albumsCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseIdentifer)
        albumsCollectionView.register(FeaturedAlbumCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedAlbumCollectionViewCell.reuseIdentifer)
        albumsCollectionView.register(SharedAlbumCollectionViewCell.self, forCellWithReuseIdentifier: SharedAlbumCollectionViewCell.reuseIdentifer)
        albumsCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: AlbumsViewController.sectionHeaderElementKind, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource <AlbumSection, AlbumItem>(collectionView: albumsCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, albumItem: AlbumItem) -> UICollectionViewCell? in

            let sectionType = AlbumSection.allCases[indexPath.section]
            switch sectionType {
            case .featuredAlbums:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedAlbumCollectionViewCell.reuseIdentifer, for: indexPath) as? FeaturedAlbumCollectionViewCell else {
                    
                        fatalError("Could not create new cell")
                }

                cell.featuredPhotoURL = albumItem.imageItems[0].thumbnailURL
                cell.title = albumItem.albumTitle
                cell.totalNumberOfImages = albumItem.imageItems.count
                
                return cell

            case .sharedAlbums:
                guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: SharedAlbumCollectionViewCell.reuseIdentifer, for: indexPath) as? SharedAlbumCollectionViewCell else {
                    
                        fatalError("Could not create new cell")
                }

                cell.featuredPhotoURL = albumItem.imageItems[0].thumbnailURL
                cell.title = albumItem.albumTitle
                
                return cell

            case .myAlbums:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifer, for: indexPath) as? AlbumCollectionViewCell else {
                    
                        fatalError("Could not create new cell")
                }

              cell.featuredPhotoURL = albumItem.imageItems[0].thumbnailURL
              cell.title = albumItem.albumTitle
                
              return cell
            }
        }
        
        dataSource.supplementaryViewProvider = {(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in

            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier,for: indexPath) as? HeaderCollectionReusableView else {
                    fatalError("Cannot create header view")
            }
            
            supplementaryView.label.text = AlbumSection.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            
            let sectionLayoutKind = AlbumSection.allCases[sectionIndex]
            
            switch (sectionLayoutKind) {
            case .featuredAlbums:
                return self.generateFeaturedAlbumsLayout(isWide: isWideView)
            case .sharedAlbums:
                return self.generateSharedlbumsLayout()
            case .myAlbums:
                return self.generateMyAlbumsLayout(isWide: isWideView)
            }
        }
        
        return layout
    }

    func generateMyAlbumsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupHeight = NSCollectionLayoutDimension.fractionalWidth(isWide ? 0.25 : 0.5)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWide ? 4 : 2)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: AlbumsViewController.sectionHeaderElementKind,
            alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    func generateFeaturedAlbumsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupFractionalWidth = isWide ? 0.475 : 0.95
        let groupFractionalHeight: Float = isWide ? 1/3 : 2/3
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: AlbumsViewController.sectionHeaderElementKind,
            alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
    
    func generateSharedlbumsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(140),
            heightDimension: .absolute(186))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: AlbumsViewController.sectionHeaderElementKind,
            alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<AlbumSection, AlbumItem> {
        let allAlbums = albumsInBaseDirectory()
        let sharingSuggestions = Array(albumsInBaseDirectory().prefix(3))
        let sharedAlbums = Array(albumsInBaseDirectory().suffix(3))

        var snapshot = NSDiffableDataSourceSnapshot<AlbumSection, AlbumItem>()
        snapshot.appendSections([AlbumSection.featuredAlbums])
        snapshot.appendItems(sharingSuggestions)

        snapshot.appendSections([AlbumSection.sharedAlbums])
        snapshot.appendItems(sharedAlbums)

        snapshot.appendSections([AlbumSection.myAlbums])
        snapshot.appendItems(allAlbums)
        
        return snapshot
    }

    func albumsInBaseDirectory() -> [AlbumItem] {
        guard let baseURL = baseURL else { return [] }

        let fileManager = FileManager.default
        do {
            return try fileManager.albumsAtURL(baseURL)
        } catch {
            print(error)
            return []
        }
    }
}

extension AlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let albumDetailVC = AlbumDetailViewController(withPhotosFromDirectory: item.albumURL)
        navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}


