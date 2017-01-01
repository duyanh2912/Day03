//
//  FeaturedModel.swift
//  Day03
//
//  Created by Duy Anh on 12/30/16.
//  Copyright © 2016 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

class FeaturedCollectionDataSource: NSObject, UICollectionViewDataSource {
    weak var collectionView: UICollectionView!
    var images = [UIImage]()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        var path = Bundle.main.resourcePath!
        path = path.appending("/Exercise1_Images/")
        
        let contents = try! FileManager.default.contentsOfDirectory(atPath: path)
        print(contents)
        for name in contents {
            images.append(UIImage(named: path.appending(name))!)
        }
        images.append(images[0])
        images.insert(images[images.count - 2], at: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: (collectionView.delegate as! ReuseCell).CELL_ID, for: indexPath) as! FeaturedCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }
}
