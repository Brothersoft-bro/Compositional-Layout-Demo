//
//  SharedAlbumCollectionViewCell.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class SharedAlbumCollectionViewCell: UICollectionViewCell {
    static let ReuseIdentifer = "SharedAlbumCollectionViewCell"
    
    let titleLabel = UILabel()
    let ownerLabel = UILabel()
    let photoImageView = UIImageView()
    let ownerAvatarImageView = UIImageView()
    let containerView = UIView()

    let owner: AlbumOwner

    var title: String? {
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
        self.owner = AlbumOwner.allCases.randomElement()!
        super.init(frame: frame)
        
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - UI methods

extension SharedAlbumCollectionViewCell {
    
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
        
        ownerLabel.translatesAutoresizingMaskIntoConstraints = false
        ownerLabel.adjustsFontForContentSizeCategory = true
        ownerLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        ownerLabel.textColor = .placeholderText
        ownerLabel.text = "From \(owner.name())"
       
        ownerAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        ownerAvatarImageView.contentMode = .scaleAspectFill
        ownerAvatarImageView.clipsToBounds = true
        ownerAvatarImageView.layer.cornerRadius = 15
        ownerAvatarImageView.layer.borderColor = UIColor.black.cgColor
        ownerAvatarImageView.layer.borderWidth = 1
        ownerAvatarImageView.image = owner.avatar()
       
        contentView.addSubview(photoImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(photoImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(ownerLabel)
        containerView.addSubview(ownerAvatarImageView)
        
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

            ownerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            ownerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ownerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ownerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            ownerAvatarImageView.heightAnchor.constraint(equalToConstant: 30),
            ownerAvatarImageView.widthAnchor.constraint(equalToConstant: 30),
            ownerAvatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),
            ownerAvatarImageView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -spacing),
        ])
    }
}
