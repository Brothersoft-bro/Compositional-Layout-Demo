//
//  HeaderCollectionReusableView.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let ReuseIdentifier = "HeaderCollectionReusableView"

    let titleLabel = UILabel()

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

extension HeaderCollectionReusableView {
    
    /// Configures the UI
    func configureUI() {
        backgroundColor = .systemBackground

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        addSubview(titleLabel)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
}

