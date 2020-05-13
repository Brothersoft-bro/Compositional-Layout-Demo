//
//  AlbumsViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    let SectionHeaderElementKind = "SectionHeaderElementKind"
    
    var albumsCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<AlbumSection, AlbumItem>!
    
    var baseURL: URL?
    
    //MARK: - Lifecycle methods
    
    convenience init(withBaseURL directoryURL: URL) {
        self.init()
        
        baseURL = directoryURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureDataSource()
    }
}


