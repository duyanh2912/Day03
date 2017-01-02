//
//  FontStylesDataSource.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

class FontStylesDataSource: NSObject, FontDataSource {
    weak var tableView: UITableView!
    var family = FontDataModel.instance.selectedFamily
    var styles = [String]()
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.styles = UIFont.fontNames(forFamilyName: family)
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
