//
//  Picker.swift
//  ScrollDatePicker
//
//  Created by Marco Pugliese on 27/01/16.
//  Copyright © 2016 Marco Pugliese. All rights reserved.
//

import UIKit

@IBDesignable class Picker: UIView {

    var view:UIView!
    var nibName:String = "Picker"
    @IBOutlet weak var dayNumbers: ScrollerNumbersCollectionView!
    @IBOutlet weak var monthNumbers: ScrollerNumbersCollectionView!
    @IBOutlet weak var yearNumbers: ScrollerNumbersCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
        
    func setup() {
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        scrollerSetup()
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
        
    }
    
    func scrollerSetup() {
        dayNumbers.initDataCell(popolateNumbers(1, to: 31), identifier: "DayNumbersCell")
        monthNumbers.initDataCell(popolateMonths(), identifier: "MonthNumbersCell")
        yearNumbers.initDataCell(popolateNumbers(1970, to: 2050), identifier: "YearNumbersCell")
    }
    
    func popolateNumbers(from:Int, to:Int) -> Array<String> {
        var out:Array<String> = []
        out.append("")
        for index in from...to {
            out.append("\(index)")
        }
        out.append("")
        return out
    }
    
    func popolateMonths() -> Array<String> {
        return ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", ""]
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
