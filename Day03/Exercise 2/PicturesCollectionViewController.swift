//
//  PicturesCollectionViewController.swift
//  Day03
//
//  Created by Duy Anh on 12/31/16.
//  Copyright © 2016 Duy Anh. All rights reserved.
//
import Utils
import UIKit

class PicturesCollectionViewController: UIViewController, UICollectionViewDelegate, ReuseCell {
    
    var dataSource: PicturesCollectionDataSource?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "PictureCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CELL_ID)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.barStyle = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.barStyle = .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if dataSource == nil {
            collectionView.delegate = self
            
            dataSource = PicturesCollectionDataSource(collectionView: collectionView)
            collectionView.dataSource = dataSource
            collectionView.collectionViewLayout = PicturesCollectionLayout()
            dataSource?.loadImages()
        }
    }
}
