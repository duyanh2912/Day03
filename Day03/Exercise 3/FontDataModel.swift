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
    var selectedFamily: String = "Arial"
    
    dynamic var favourites: [String] = [] {
        didSet {
            saveFavourites()
        }
    }
    
    override init() {
        super.init()
        loadFavourites()
    }
    
    func loadFavourites() {
        let standard = UserDefaults.standard
        if let favourites = standard.array(forKey: "favourites") as? [String] {
            self.favourites = favourites
        }
    }
    
    func saveFavourites() {
        let standard = UserDefaults.standard
        standard.set(favourites, forKey: "favourites")
    }
}
