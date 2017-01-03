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
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btn.imageEdgeInsets.left = 25
        let image = UIImage(imageLiteralResourceName: "favourites").withRenderingMode(.alwaysTemplate)
        
        btn.setImage(image, for: .normal)
        btn.addTarget(tableView.delegate, action: #selector(FontStylesViewController.tappedAccessoryButton), for: .touchUpInside)
        
        btn.tintColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
        
        if !dataModel.favourites.contains(styles[indexPath.row]) {
            cell.accessoryView = btn
        }
        
        return cell
    }
}
