//
//  PhotoViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let photoImageView = UIImageView()
    var photoURL: URL?
    
    //MARK: - Lifecycle methods
    
    convenience init(photoURL: URL) {
        self.init()
        
        self.photoURL = photoURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
}
