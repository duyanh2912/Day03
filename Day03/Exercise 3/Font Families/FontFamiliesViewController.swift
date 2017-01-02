//
//  FontsViewController.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class FontFamiliesViewController: FontViewController {
    override func configDataSource() {
        if dataSource == nil {
            dataSource = FontFamiliesDataSource(tableView: tableView)
            tableView.dataSource = dataSource
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
            vc.favourites = (dataSource as! FontFamiliesDataSource).dataModel.favourites
        }
    }
}
