//
//  PicturesCollectionDataSource.swift
//  Day03
//
//  Created by Duy Anh on 12/31/16.
//  Copyright © 2016 Duy Anh. All rights reserved.
//
import Utils
import UIKit
import Foundation

class PicturesCollectionDataSource: NSObject, UICollectionViewDataSource {
    weak var collectionView: UICollectionView!
    var thumbnails = [UIImage?]()
    
    var path: String!
    var contents = [String]()
    var itemCount: Int = 0
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        guard let path = Bundle.main.resourcePath?.appending("/Exercise2_Images/") else { return }
        self.path = path
        
        guard let contents = try? FileManager.default.contentsOfDirectory(atPath: path) else { return }
        self.contents = contents
    }
    
    func loadImages() {
        DispatchQueue.global().async {
            for index in 0 ..< self.contents.count {
                let data = FileManager.default.contents(atPath: self.path.appending(self.contents[index]))
                let image = UIImage(data: data!)!
                
                self.thumbnails.append(UIImage.thumbnail(of: image, scaledToFillSize: CGSize(width: 300, height: 300)))
                
                DispatchQueue.main.sync {
                    self.collectionView.insertItems(at: [IndexPath(item: index, section: 0)])
                }
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func getThumbnail(index: Int) -> UIImage {
        return thumbnails[index]!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: (collectionView.delegate as! ReuseCell).CELL_ID, for: indexPath) as? PictureCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        DispatchQueue.global().async { [unowned self] in
            let image = self.getThumbnail(index: indexPath.item)
            
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        
        return cell
    }
}
