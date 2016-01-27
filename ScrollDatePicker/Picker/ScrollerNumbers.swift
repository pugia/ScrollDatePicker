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
    
    private var data:Array<String> = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
        self.delegate = self
        self.registerClass(ScrollerNumbersCollectionViewCell.self, forCellWithReuseIdentifier: self.cell_identifier)
        self.alwaysBounceVertical = false
        self.showsVerticalScrollIndicator = false
        self.canCancelContentTouches = true
        self.bounces = false
        
    }
    
    func initDataCell(data:Array<String>, identifier:String) {
        self.cell_identifier = identifier
        self.data = data
        self.registerClass(ScrollerNumbersCollectionViewCell.self, forCellWithReuseIdentifier: self.cell_identifier)
        self.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cell_identifier, forIndexPath: indexPath) as! ScrollerNumbersCollectionViewCell
        cell.label.text = data[indexPath.row]
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