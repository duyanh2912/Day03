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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let removeAllButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAll))
        navigationItem.rightBarButtonItem = removeAllButton
    }
    
    func removeAll(sender: UIBarButtonItem) {
        let count = dataSource!.dataModel.favourites.count
        dataSource?.dataModel.favourites.removeAll()
        
        var paths = [IndexPath]()
        for i in 0 ..< count {
            paths.append(IndexPath(row: i, section: 0))
        }
        tableView.deleteRows(at: paths, with: .automatic)
        sender.isEnabled = false
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        if tableView.numberOfRows(inSection: 0) == 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
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
