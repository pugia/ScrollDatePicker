//
//  ScrollerNumbers.swift
//  ScrollDatePicker
//
//  Created by Marco Pugliese on 27/01/16.
//  Copyright © 2016 Marco Pugliese. All rights reserved.
//

import Foundation
import UIKit


class ScrollerNumbersCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var cell_identifier = "Cell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
//        layout.itemSize = CGSize(width: frame.width, height: frame.height/3)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        self.collectionViewLayout = layout
        
        self.dataSource = self
        self.delegate = self
        self.registerClass(ScrollerNumbersCollectionViewCell.self, forCellWithReuseIdentifier: self.cell_identifier)
        self.backgroundColor = UIColor.redColor()
        self.alwaysBounceVertical = false
        self.showsVerticalScrollIndicator = false
        self.canCancelContentTouches = true
        self.bounces = false
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cell_identifier, forIndexPath: indexPath) as! ScrollerNumbersCollectionViewCell
        cell.label.text = "\(indexPath.row)"
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height/3)
    }
    
    override func touchesShouldCancelInContentView(view: UIView) -> Bool {
        return true
    }
    
}

class ScrollerNumbersCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.grayColor()
        label.frame =  CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        label.textAlignment = .Center
        label.textColor = UIColor.blackColor()
        
        self.addSubview(label)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}