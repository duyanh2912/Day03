//
//  FontStylesDataSource.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

class FontStylesDataSource: NSObject, UITableViewDataSource {
    weak var tableView: UITableView!
    var family: String!
    var styles = [String]()
    
    init(tableView: UITableView, fontFamily: String) {
        self.tableView = tableView
        self.family = fontFamily
        self.styles = UIFont.fontNames(forFamilyName: fontFamily)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (tableView.delegate as! ReuseCell).CELL_ID, for: indexPath)
        cell.textLabel?.text = styles[indexPath.row]
        cell.textLabel?.font = UIFont(name: styles[indexPath.row], size: 17)
        
        return cell
    }
    
    func addToFavourites() {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name.init(rawValue: "favourites"), object: nil, userInfo: ["family" : family])
    }
}
