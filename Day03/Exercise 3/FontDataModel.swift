//
//  FontDataModel.swift
//  Day03
//
//  Created by Duy Anh on 1/2/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

class FontDataModel: NSObject {
    static var instance = FontDataModel()
    
    var allFonts: [String] {
        return UIFont.familyNames.sorted()
    }
    dynamic var favourites: [String]
    
    override init() {
        self.favourites = []
        super.init()
    }
}
