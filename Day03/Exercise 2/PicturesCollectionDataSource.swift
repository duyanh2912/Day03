//
//  PicturesCollectionDataSource.swift
//  Day03
//
//  Created by Duy Anh on 12/31/16.
//  Copyright © 2016 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

class PicturesCollectionDataSource: NSObject, UICollectionViewDataSource {
    weak var collectionView: UICollectionView!
    var images = [UIImage]()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        guard var path = Bundle.main.resourcePath else { return }
        path = path.appending("/Exercise2_Images/")
        
        guard let contents = try? FileManager.default.contentsOfDirectory(atPath: path) else { return }
        for name in contents {
            images.append(UIImage(named: path.appending(name))!)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesCollectionViewController.CELL_ID, for: indexPath) as? PictureCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = images[indexPath.row]
        return cell
    }
}
