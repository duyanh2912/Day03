//
//  FontFamiliesDataSource.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

class FontFamiliesDataSource: NSObject, FontDataSource {
    weak var tableView: UITableView!
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        setKVO()
    }
        
    func setKVO() {
        dataModel.addObserver(self, forKeyPath: #keyPath(FontDataModel.favourites), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableView.reloadData()
    }
    
    func favouritesReceived(notification: Notification) {
        let font = notification.userInfo?["font"] as! String
        dataModel.favourites.append(font)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "All Font Families"
        }
        return "My Favourites Fonts"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if dataModel.favourites.isEmpty { return 1 }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return dataModel.allFonts.count }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (tableView.delegate as! ReuseCell).CELL_ID, for: indexPath)
        
        DispatchQueue.global().async { [unowned self] in
            if indexPath.section == 0 {
                let font = self.dataModel.allFonts[indexPath.row]
                DispatchQueue.main.async {
                    cell.textLabel?.text = self.dataModel.allFonts[indexPath.row]
                    cell.textLabel?.font = UIFont(name: font, size: 17)
                }
                
            } else {
                let font = UIFont.systemFont(ofSize: 17)
                DispatchQueue.main.async {
                    cell.textLabel?.text = "Favourites"
                    cell.textLabel?.font = font
                }
            }
        }
        
        return cell
    }
}
