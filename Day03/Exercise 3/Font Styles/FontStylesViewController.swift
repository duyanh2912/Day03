//
//  FontStylesViewController.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class FontStylesViewController: FontViewController {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "StylesToInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StylesToInfo" {
            guard let vc = segue.destination as? FontInfoViewController else { return }
            vc.font = tableView.cellForRow(at: tableView.indexPathForSelectedRow!)?.textLabel?.text!
        }
    }
    
    func tappedAccessoryButton(sender: UIButton, event: UIEvent) {
        let ac = UIAlertController(title: "Add this style to favourites?", message: nil, preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { [unowned self]
            _ in
            guard let touch = event.allTouches?.first?.location(in: self.tableView) else { return }
            guard let indexPath = self.tableView.indexPathForRow(at: touch) else { return }
            guard let cell = self.tableView.cellForRow(at: indexPath) else { return }
            
            self.dataSource?.addFontToFavourites(cell.textLabel!.text!)
            UIView.animate(withDuration: 0.5, animations: { sender.alpha = 0 }) { completed in
                if completed == true { sender.isHidden = true }
            }
        }
        let no = UIAlertAction(title: "No", style: .default)
        ac.addAction(yes)
        ac.addAction(no)
        present(ac, animated: true)
    }
}
