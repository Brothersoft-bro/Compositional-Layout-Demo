//
//  AlbumOwner.swift
//  CompositionalLayoutDemo
//
//  Created by Brothersoft on 11/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation
import UIKit

enum AlbumOwner: Int, CaseIterable {
    case Jack
    case Jennifer
    case Martin

    func avatar() -> UIImage {
        switch self {
        case .Jack:
            return #imageLiteral(resourceName: "profile_1")
        case .Jennifer:
            return #imageLiteral(resourceName: "profile_2")
        case .Martin:
            return #imageLiteral(resourceName: "profile_3")
        }
    }

    func name() -> String {
        switch self {
        case .Jack:
            return "Jack Smith"
        case .Jennifer:
            return "Jennifer Smith"
        case .Martin:
            return "Martin Smith"
        }
    }
}
