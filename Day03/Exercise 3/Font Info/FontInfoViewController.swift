//
//  FontInfoViewController.swift
//  Day03
//
//  Created by Duy Anh on 1/2/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class FontInfoViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var slider: UISlider!
    var font: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.font = UIFont(name: font, size: CGFloat(slider.value))
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = font
    }
    
    @IBAction func slided(_ sender: UISlider) {
        print(sender.value)
        textView.font = textView.font?.withSize(CGFloat(sender.value))
    }
}
