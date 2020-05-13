//
//  AlbumsViewController+UICollectionViewDelegate.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 10/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDelegate methods

extension AlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let albumItem = dataSource.itemIdentifier(for: indexPath) else { return }
        let albumDetailViewController = AlbumDetailViewController(withAlbumURL: albumItem.url)
        
        navigationController?.pushViewController(albumDetailViewController, animated: true)
    }
}
