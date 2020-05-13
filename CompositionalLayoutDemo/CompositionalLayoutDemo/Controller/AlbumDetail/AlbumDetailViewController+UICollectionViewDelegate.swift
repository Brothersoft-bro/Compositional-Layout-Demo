//
//  AlbumDetailViewController+UICollectionViewDelegate.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 10/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDelegate methods

extension AlbumDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photoItem = dataSource.itemIdentifier(for: indexPath) else { return }
        let photoDetailViewController = PhotoViewController(photoURL: photoItem.url)
        
        navigationController?.pushViewController(photoDetailViewController, animated: true)
    }
}
