//
//  PhotoItem.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation

struct PhotoItem {
    let url: URL
       
    private let identifier = UUID()
       
    //MARK: - Lifecycle methods
    
    init(photoURL: URL) {
        self.url = photoURL
    }
}

//MARK: - Hashable

extension PhotoItem: Hashable {
   func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
