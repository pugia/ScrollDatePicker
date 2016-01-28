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
    
    var callback: (Void -> Void)?
    var cellHeight:CGFloat = 0
    
    @IBInspectable var cell_identifier: String = "Cell"
    
    private var data:Array<String> = []
    private var ipsilon:CGFloat = 0
    private var selected:Int = 1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
        self.delegate = self
        self.registerClass(ScrollerNumbersCollectionViewCell.self, forCellWithReuseIdentifier: self.cell_identifier)
        self.alwaysBounceVertical = true
        self.showsVerticalScrollIndicator = false
        self.canCancelContentTouches = true
        self.bounces = true
        
    }
    
    func initDataCell(data:Array<String>) {
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
    
    override func touchesShouldCancelInContentView(view: UIView) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.ipsilon = round(scrollView.contentOffset.y / self.cellHeight) * self.cellHeight
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.ipsilon = round(scrollView.contentOffset.y / self.cellHeight) * self.cellHeight
        _ = Timeout(0.2) {
            self.fixCellPosition(scrollView)
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y == 0) {
            _ = Timeout(0.2) {
                self.ipsilon = round(scrollView.contentOffset.y / self.cellHeight) * self.cellHeight
                self.fixCellPosition(scrollView)
            }
        }
    }

    func fixCellPosition(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.1, animations: {
            scrollView.contentOffset.y = self.ipsilon
        })
        self.selected = Int(self.ipsilon / self.cellHeight) + 1
        _ = Timeout(0.1) {
            self.callback?()
        }
    }

    func setCurrentElement(i:Int, offset:Int=0) {
        self.selected = i
        self.contentOffset.y = self.cellHeight * CGFloat(i-1+offset)
    }
    
    func getCurrentElement() -> Int {
        return self.selected
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if (self.cellHeight == 0) {
            self.cellHeight = self.frame.height/3
        }
        return CGSize(width: self.frame.width, height: self.frame.height/3)
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
        label.font = UIFont(name: "DINCondensedBold.ttf", size: 20);
        
        self.addSubview(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

/// Timeout wrapps a callback deferral that may be cancelled.
///
/// Usage:
/// Timeout(1.0) { println("1 second has passed.") }
///
class Timeout: NSObject
{
    private var timer: NSTimer?
    private var callback: (Void -> Void)?
    
    init(_ delaySeconds: Double, _ callback: Void -> Void)
    {
        super.init()
        self.callback = callback
        self.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(delaySeconds),
            target: self, selector: "invoke", userInfo: nil, repeats: false)
    }
    
    func invoke()
    {
        self.callback?()
        // Discard callback and timer.
        self.callback = nil
        self.timer = nil
    }
    
    func cancel()
    {
        self.timer?.invalidate()
        self.timer = nil
    }
}