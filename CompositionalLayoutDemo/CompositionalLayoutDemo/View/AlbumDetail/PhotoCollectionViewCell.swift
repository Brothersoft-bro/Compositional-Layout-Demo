//
//  PhotoCollectionViewCell.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "PhotoCollectionViewCell"
    
    let photoImageView = UIImageView()
    let containerView = UIView()
    
    var photoURL: URL? {
        didSet {
            configureUI()
        }
    }
    
    //MARK: - Lifecycle methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI methods

extension PhotoCollectionViewCell {
    
    /// Configures the UI
    func configureUI() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let photoURL = self.photoURL else { return }
        let photo = UIImage(contentsOfFile: photoURL.path)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.image = photo

        contentView.addSubview(containerView)
        containerView.addSubview(photoImageView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            photoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
}
