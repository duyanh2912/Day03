//
//  FontFamiliesDataSource.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

class FontFamiliesDataSource: NSObject, UITableViewDataSource {
    weak var tableView: UITableView!
    var fontNames = [String]()
    var fonts = [UIFont]()
    var favourites: [String] = []
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        setNotification()
    }
    
    func getFonts() {
        tableView.reloadData()
        DispatchQueue.global().async { [unowned self] in
            for (index, font) in UIFont.familyNames.sorted().enumerated() {
                self.fontNames.append(font)
                self.fonts.append(UIFont(name: font, size: 17)!)
                DispatchQueue.main.sync {
                    self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
        }
    }
    
    func setNotification() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(favouritesReceived(notification:)), name: Notification.Name.init(rawValue: "favourites"), object: nil)
    }
    
    func favouritesReceived(notification: Notification) {
        let family = notification.userInfo?["family"] as! String
        self.favourites.append(family)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "All Font Families"
        }
        return "My Favourites Fonts"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if favourites.isEmpty { return 1 }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return fontNames.count }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (tableView.delegate as! ReuseCell).CELL_ID, for: indexPath)
        
        DispatchQueue.global().async { [unowned self] in
            if indexPath.section == 0 {
                let font = self.fonts[indexPath.row]
                DispatchQueue.main.async {
                    cell.textLabel?.text = self.fontNames[indexPath.row]
                    cell.textLabel?.font = font
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
