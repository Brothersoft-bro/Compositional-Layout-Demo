//
//  PhotoViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Norbert Korosi on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let imageView = UIImageView()
    var photoURL: URL?
    
    convenience init(photoURL: URL) {
        self.init()
        self.photoURL = photoURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photoURL = photoURL {
            let imageName = photoURL.lastPathComponent
            navigationItem.title = imageName

            let image = UIImage(contentsOfFile: photoURL.path)
            imageView.image = image;
            imageView.contentMode = .scaleAspectFit

            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            view.backgroundColor = .systemBackground

            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                imageView.topAnchor.constraint(equalTo: view.topAnchor)
            ])
        }
    }
}
