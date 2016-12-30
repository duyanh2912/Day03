//
//  ViewController.swift
//  Day03
//
//  Created by Duy Anh on 12/30/16.
//  Copyright © 2016 Duy Anh. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: FeaturedCollectionDataSource!
    
    static let CELL_ID = "Cell"
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "FeaturedCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: type(of: self).CELL_ID)
        
        collectionView.delegate = self
        
        dataSource = FeaturedCollectionDataSource(collectionView: collectionView)
        collectionView.dataSource = dataSource
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.scrollToItem(at: IndexPath(row: 1, section : 0), at: .left, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [unowned self]
                _ in
                self.autoScroll()
            }
        }
    }
    
    func autoScroll() {
        guard let cell = collectionView.visibleCells.first else { return }
        guard let row = collectionView.indexPath(for: cell)?.row else { return }
        
        var destination = row + 1
        destination = (row >= dataSource.images.count - 1) ? 1 : destination
        
        print(destination)
        
        collectionView.scrollToItem(at: IndexPath(row: destination, section: 0), at: .left, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width
        let pageCount = CGFloat(dataSource.images.count)
        let fullOffset = pageWidth * (pageCount - 1)
        
        if (scrollView.contentOffset.x >= fullOffset) {
            
            // user is scrolling to the right from the last item to the 'fake' item 1.
            // reposition offset to show the 'real' item 1 at the left-hand end of the collection view
            
            collectionView.setContentOffset(
                CGPoint(x: scrollView.contentOffset.x - fullOffset + pageWidth,y: 0),
                animated: false
            )
            
        } else if (scrollView.contentOffset.x <= 0) {
            
            // user is scrolling to the left from the first item to the fake 'item N'.
            // reposition offset to show the 'real' item N at the right end end of the collection view
            
            collectionView.setContentOffset(
                CGPoint(x: scrollView.contentOffset.x + fullOffset - pageWidth,y: 0),
                animated: false
            )
        }

    }
}