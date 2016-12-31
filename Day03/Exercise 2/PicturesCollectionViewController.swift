//
//  PicturesCollectionViewController.swift
//  Day03
//
//  Created by Duy Anh on 12/31/16.
//  Copyright © 2016 Duy Anh. All rights reserved.
//
import Utils
import UIKit

class PicturesCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    static let CELL_ID = "Cell"
    var dataSource: PicturesCollectionDataSource!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "PictureCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: type(of: self).CELL_ID)
        
        collectionView.delegate = self
        
        dataSource = PicturesCollectionDataSource(collectionView: collectionView)
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = PicturesCollectionLayout()
    }
}
