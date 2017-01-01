//
//  FavouritesViewController.swift
//  Day03
//
//  Created by Duy Anh on 1/2/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, ReuseCell {
    @IBOutlet var tableView: UITableView!
    var dataSource: UITableViewDataSource?
    var favourites: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        
        dataSource = FavouritesDataSource(tableView: tableView, fonts: favourites)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FavouritesToInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavouritesToInfo" {
            guard let vc = segue.destination as? FontInfoViewController else { return }
            vc.font = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)?.textLabel?.text!
        }
    }
}
