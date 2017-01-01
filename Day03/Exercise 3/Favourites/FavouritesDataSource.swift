//
//  FavouritesDataSource.swift
//  Day03
//
//  Created by Duy Anh on 1/2/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

class FavouritesDataSource: NSObject, UITableViewDataSource {
    weak var tableView: UITableView!
    var fonts: [String]
    
    init(tableView: UITableView, fonts: [String]) {
        self.tableView = tableView
        self.fonts = fonts
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (tableView.delegate as! ReuseCell).CELL_ID, for: indexPath)
        cell.textLabel?.text = fonts[indexPath.row]
        cell.textLabel?.font = UIFont(name: fonts[indexPath.row], size: 17)
        return cell
    }
}
