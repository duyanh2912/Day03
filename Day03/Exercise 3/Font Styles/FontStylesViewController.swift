//
//  FontStylesViewController.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class FontStylesViewController: UIViewController, UITableViewDelegate, ReuseCell {
    @IBOutlet var tableView: UITableView!
    var dataSource: UITableViewDataSource?
    var family: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        
        dataSource = FontStylesDataSource(tableView: tableView, fontFamily: family)
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavourites))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = family
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Styles", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func addToFavourites() {
        let ac = UIAlertController(title: "Add this font to favourites?", message: nil, preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { [unowned self] _ in
            (self.dataSource as! FontStylesDataSource).addToFavourites()
            
            let ac2 = UIAlertController(title: "Added to favourites", message: nil, preferredStyle: .alert)
            ac2.addAction(.init(title: "Okay", style: .default))
            self.present(ac2, animated: true)
        }
        
        let no = UIAlertAction(title: "No", style: .default)
        ac.addAction(no)
        ac.addAction(yes)
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
