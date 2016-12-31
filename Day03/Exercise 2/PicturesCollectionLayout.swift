//
//  PicturesCollectionLayout.swift
//  Day03
//
//  Created by Duy Anh on 12/31/16.
//  Copyright © 2016 Duy Anh. All rights reserved.
//

import UIKit

class PicturesCollectionLayout: UICollectionViewLayout {
    
    var contentWidth: CGFloat = 0
    var contentHeight: CGFloat = 0
    var cache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        guard cache.isEmpty else { return }
        guard let numberOfItems = collectionView?.numberOfItems(inSection: 0) else { return }
        
        contentWidth = collectionView!.width
        
        if (numberOfItems - 1) % 6 <= 2 {
            contentHeight = contentWidth * CGFloat((numberOfItems - 1) / 6) + contentWidth * 2 / 3
        } else {
            contentHeight = contentWidth * CGFloat((numberOfItems - 1) / 6) + contentWidth
        }
        
        for i in 0 ..< numberOfItems {
            let atr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            var size = CGSize(width: contentWidth / 3, height: contentWidth / 3)
            var origin = CGPoint(x: 0, y: CGFloat(i / 6) * contentWidth)
            
            switch i % 6 {
            case 0:
                size = size.scale(by: 2)
            case 1, 2:
                origin = origin.add(x: contentWidth * 2 / 3, y: CGFloat(i % 6 - 1) * contentWidth / 3)
            default:
                origin = origin.add(x: CGFloat(i % 6 - 3) * contentWidth / 3, y: contentWidth * 2 / 3)
            }
            
            atr.frame = CGRect(origin: origin, size: size)
            cache.append(atr)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
