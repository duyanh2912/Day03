//
//  FontsViewController.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class FontFamiliesViewController: UIViewController, UITableViewDelegate, ReuseCell {
    @IBOutlet var tableView: UITableView!
    var dataSource: UITableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if dataSource == nil {
            self.dataSource = FontFamiliesDataSource(tableView: tableView)
            tableView.dataSource = dataSource
            (dataSource as! FontFamiliesDataSource).getFonts()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "FontFamiliesToFontStyles", sender: self)
        } else if indexPath.section == 1 {
            performSegue(withIdentifier: "FamiliesToFavourites", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FontFamiliesToFontStyles" {
            guard let vc = segue.destination as? FontStylesViewController else { return }
            vc.family = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)?.textLabel?.text!
        } else if segue.identifier == "FamiliesToFavourites" {
            guard let vc = segue.destination as? FavouritesViewController else { return }
            vc.favourites = (dataSource as! FontFamiliesDataSource).favourites
        }
    }
}
