//
//  ScrollDatePicker.swift
//  ScrollDatePicker
//
//  Created by Marco Pugliese on 10/01/16.
//  Copyright © 2016 Marco Pugliese. All rights reserved.
//

import UIKit

class ScrollDatePicker {

    let container:UIView!
    
    let dayHandler:ScrollerBackCollectionView!
//    let monthHandler:ScrollerBackCollectionView!
    
    init(container_view:UIView) {
        container = container_view
        container.backgroundColor = UIColor.redColor()
        let dayFrame = CGRect(x: 0, y: 0, width: 100, height: container.frame.height)
        dayHandler = ScrollerBackCollectionView(frame: dayFrame, identifier: "day")
        container.addSubview(dayHandler)

//        let monthFrame = CGRect(x: 51, y: 0, width: 50, height: container.frame.height)
//        monthHandler = ScrollerBackCollectionView(frame: monthFrame, identifier: "month")
//        container.addSubview(monthHandler)
    
    
    }
    
}

class ScrollerBackCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {

    var cell_identifier = "Cell"
    
    init(frame: CGRect, identifier: String) {
        
        cell_identifier = identifier
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.itemSize = CGSize(width: frame.width, height: frame.height/2.3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        self.registerClass(ScrollerCollectionViewCell.self, forCellWithReuseIdentifier: cell_identifier)
        self.backgroundColor = UIColor.redColor()
        self.alwaysBounceVertical = false
        self.showsVerticalScrollIndicator = false
        self.canCancelContentTouches = true
        self.bounces = false
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cell_identifier, forIndexPath: indexPath) as! ScrollerCollectionViewCell
        cell.label.text = "\(indexPath.row)"
        return cell
        
    }
    
}

class ScrollerCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.grayColor()
        
        label.frame = frame
        label.textAlignment = .Center
        label.textColor = UIColor.blackColor()
        
        self.addSubview(label)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}