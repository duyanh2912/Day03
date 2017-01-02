//
//  FontStylesViewController.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class FontStylesViewController: FontViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavourites))
        navigationItem.rightBarButtonItem = addButton
        
        if dataSource!.dataModel.favourites.contains(dataSource!.dataModel.selectedFamily) {
            DispatchQueue.main.async {
                addButton.isEnabled = false
            }
        }
    }
    
    override func configDataSource() {
        if dataSource == nil {
            dataSource = FontStylesDataSource(tableView: tableView)
            tableView.dataSource = dataSource
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = dataSource?.dataModel.selectedFamily
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Styles", style: .plain, target: nil, action: nil)
    }
    
    func addToFavourites() {
        let ac = UIAlertController(title: "Add this font to favourites?", message: nil, preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { [unowned dataSource = self.dataSource!]
            _ in
            dataSource.dataModel.favourites.append(dataSource.dataModel.selectedFamily)
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        let no = UIAlertAction(title: "No", style: .default)
        ac.addAction(yes)
        ac.addAction(no)
        present(ac, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "StylesToInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StylesToInfo" {
            guard let vc = segue.destination as? FontInfoViewController else { return }
            vc.font = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)?.textLabel?.text!
        }
    }
}
