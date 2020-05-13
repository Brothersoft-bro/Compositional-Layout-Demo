//
//  FileManager+Extension.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation

extension FileManager {
    func albumsAtURL(_ url: URL) -> [AlbumItem] {
        guard let albumDirectories = try? self.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else {
            return []
        }
        
        var albums = [AlbumItem]()
        for albumURL in albumDirectories {
            if let resourceValues = try? albumURL.resourceValues(forKeys: [.isDirectoryKey]), let isDirectory = resourceValues.isDirectory, isDirectory {
                let photos = photosAtURL(albumURL)
                
                albums.append(AlbumItem(albumURL: albumURL, photos: photos))
            }
        }
        
        return albums
    }

    func photosAtURL(_ url: URL) -> [PhotoItem] {
        guard let photoFiles = try? self.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else {
            return []
            
        }

        var photos = [PhotoItem]()
        for photoURL in photoFiles {
            if let resourceValues = try? photoURL.resourceValues(forKeys: [.isDirectoryKey]), let isDirectory = resourceValues.isDirectory, !isDirectory {
                let photo = PhotoItem(photoURL: photoURL)
                
                photos.append(photo)
            }
        }
        
        return photos
    }
}
