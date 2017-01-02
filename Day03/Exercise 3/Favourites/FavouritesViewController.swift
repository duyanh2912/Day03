//
//  FavouritesViewController.swift
//  Day03
//
//  Created by Duy Anh on 1/2/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class FavouritesViewController: FontViewController {
    override func configDataSource() {
        if dataSource == nil {
            dataSource = FavouritesDataSource(tableView: tableView)
            tableView.dataSource = dataSource
        }
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
