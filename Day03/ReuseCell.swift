//
//  ReuseCell.swift
//  Day03
//
//  Created by Duy Anh on 1/1/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

protocol ReuseCell {
    var CELL_ID: String { get }
}

extension ReuseCell where Self: UIViewController {
    var CELL_ID: String {
        return "Cell"
    }
}

