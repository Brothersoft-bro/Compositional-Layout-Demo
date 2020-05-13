//
//  String+Extension.swift
//  CompositionalLayoutDemo
//
//  Created by Norbert Korosi on 08/05/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import Foundation

extension String {
    var userFriendlyText: String {
        let firstUppercased = prefix(1).uppercased() + dropFirst()
        
        return firstUppercased.replacingOccurrences(of: "_", with: " ")
    }
}
