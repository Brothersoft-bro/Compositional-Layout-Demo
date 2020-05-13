//
//  AlbumDetailViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    let SyncingBadgeKind = "SyncingBadgeKind"
    
    var dataSource: UICollectionViewDiffableDataSource<AlbumDetailSection, PhotoItem>!
    var albumDetailCollectionView: UICollectionView!
    
    var albumURL: URL?
    
    //MARK: - Lifecycle methods
    
    convenience init(withAlbumURL directoryURL: URL) {
        self.init()
        
        albumURL = directoryURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureDataSource()
    }
}
