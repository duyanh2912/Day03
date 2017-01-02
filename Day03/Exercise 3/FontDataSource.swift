//
//  FontDataSource.swift
//  Day03
//
//  Created by Duy Anh on 1/2/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

protocol FontDataSource: UITableViewDataSource {
    var tableView: UITableView! { get set }
    var dataModel: FontDataModel { get }
}

extension FontDataSource {
    var dataModel: FontDataModel {
        return FontDataModel.instance
    }
}
