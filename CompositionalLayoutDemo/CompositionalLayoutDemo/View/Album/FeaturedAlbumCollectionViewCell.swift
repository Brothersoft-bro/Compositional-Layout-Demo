//
//  FeaturedAlbumCollectionViewCell.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class FeaturedAlbumCollectionViewCell: UICollectionViewCell {
    static let ReuseIdentifer = "FeaturedAlbumCollectionViewCell"
    
    let titleLabel = UILabel()
    let photosCountLabel = UILabel()
    let photoImageView = UIImageView()
    let containerView = UIView()

    var title: String? {
        didSet {
            configureUI()
        }
    }

    var numberOfPhotos: Int? {
        didSet {
           configureUI()
        }
    }

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

extension FeaturedAlbumCollectionViewCell {
    
    /// Configures the UI
    func configureUI() {
        containerView.translatesAutoresizingMaskIntoConstraints = false

        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 4
        
        if let photoURL = photoURL {
            photoImageView.image = UIImage(contentsOfFile: photoURL.path)
        }

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        titleLabel.text = title
       
        photosCountLabel.translatesAutoresizingMaskIntoConstraints = false
        photosCountLabel.adjustsFontForContentSizeCategory = true
        photosCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        photosCountLabel.textColor = .placeholderText
        if let numberOfPhotos = numberOfPhotos {
            photosCountLabel.text = "\(numberOfPhotos) photos"
        }
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(photoImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(photosCountLabel)
        
        let spacing = CGFloat(10)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            photoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),

            titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor),

            photosCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            photosCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
