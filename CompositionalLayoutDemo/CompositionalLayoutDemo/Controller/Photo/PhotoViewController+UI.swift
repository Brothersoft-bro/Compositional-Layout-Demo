//
//  PhotoViewController+UI.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 10/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation
import UIKit

extension PhotoViewController {
    
    //MARK: - Public methods
    
    /// Configures the UI
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = photoURL?.lastPathComponent
        
        configureImageView()
    }
    
    //MARK: - Private methods
    
    /// Configures the photo image view
    private func configureImageView() {
        guard let photoURL = photoURL else { return }
        
        let image = UIImage(contentsOfFile: photoURL.path)
        photoImageView.image = image
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
