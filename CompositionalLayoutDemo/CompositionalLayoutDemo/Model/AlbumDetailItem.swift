//
//  AlbumDetailItem.swift
//  CompositionalLayoutDemo
//
//  Created by Norbert Korosi on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation

struct AlbumDetailItem {
    let photoURL: URL
    let thumbnailURL: URL
       
    private let identifier = UUID()
       
    //MARK: - Lifecycle methods
    
    init(photoURL: URL, thumbnailURL: URL) {
        self.photoURL = photoURL
        self.thumbnailURL = thumbnailURL
    }
}

//MARK: - Hashable

extension AlbumDetailItem: Hashable {
   func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: AlbumDetailItem, rhs: AlbumDetailItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

enum AlbumDetailSection {
    case albumBody
}
