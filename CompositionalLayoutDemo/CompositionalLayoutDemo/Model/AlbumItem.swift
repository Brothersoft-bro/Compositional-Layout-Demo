//
//  AlbumItem.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation

struct AlbumItem {
    let url: URL
    let title: String
    let photos: [PhotoItem]

    private let identifier = UUID()
    
    //MARK: - Lifecycle methods
    
    init(albumURL: URL, photos: [PhotoItem]) {
        self.url = albumURL
        self.title = albumURL.lastPathComponent
        self.photos = photos
    }
}

//MARK: - Hashable

extension AlbumItem: Hashable {
   func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: AlbumItem, rhs: AlbumItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

