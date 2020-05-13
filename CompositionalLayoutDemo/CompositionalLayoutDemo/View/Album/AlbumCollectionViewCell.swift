//
//  AlbumCollectionViewCell.swift
//  CompositionalLayoutDemo
//
//  Created by Norbert Korosi on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "album-item-cell-reuse-identifier"
    let titleLabel = UILabel()
    let featuredPhotoView = UIImageView()
    let contentContainer = UIView()

    var title: String? {
        didSet {
            configure()
        }
    }

    var featuredPhotoURL: URL? {
        didSet {
            configure()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumCollectionViewCell {
    func configure() {
        contentContainer.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(featuredPhotoView)
        contentView.addSubview(contentContainer)

        featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false
        if let featuredPhotoURL = featuredPhotoURL {
            featuredPhotoView.image = UIImage(contentsOfFile: featuredPhotoURL.path)
        }
        featuredPhotoView.clipsToBounds = true
        contentContainer.addSubview(featuredPhotoView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowRadius = 3.0
        titleLabel.layer.shadowOpacity = 1.0
        titleLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        titleLabel.layer.masksToBounds = false
        contentContainer.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            featuredPhotoView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
