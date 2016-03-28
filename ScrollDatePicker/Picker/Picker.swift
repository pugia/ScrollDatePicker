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

    var date = NSDate()
    
    @IBOutlet weak var dayNumbers: ScrollerNumbersCollectionView!
    @IBOutlet weak var monthNumbers: ScrollerNumbersCollectionView!
    @IBOutlet weak var yearNumbers: ScrollerNumbersCollectionView!
    @IBOutlet weak var hourNumbers: ScrollerNumbersCollectionView!
    @IBOutlet weak var minuteNumbers: ScrollerNumbersCollectionView!
    
    @IBOutlet weak var dayHandler: ScrollerHandlerCollectionView!
    @IBOutlet weak var monthHandler: ScrollerHandlerCollectionView!
    @IBOutlet weak var yearHandler: ScrollerHandlerCollectionView!
    @IBOutlet weak var hourHandler: ScrollerHandlerCollectionView!
    @IBOutlet weak var minuteHandler: ScrollerHandlerCollectionView!

    // labels
    // dayLabel
    @IBOutlet weak var dayLabel: myLabel!
    @IBOutlet weak var dayLabelLeadingC: NSLayoutConstraint!
    
    
    private var day:Int = 3
    private var month:Int = 1
    private var year:Int = 1986
    private var hour:Int = 7
    private var minute:Int = 15
    
    private let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
    
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
        
        let components = calendar!.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: date)
        day = components.day
        month = components.month
        year = components.year
        hour = components.hour
        minute = components.minute
        scrollerSetup()
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
        
    }
    
    func animateLabels() {
        // dayLabel
//        dayLabel.animateToFontSize(40, withDuration: 1)
        UIView.animateWithDuration(1, animations: {
            let f = self.dayNumbers.frame
            let h = f.height/3
            let fr = CGRect(x: f.origin.x, y: f.origin.y + h, width: f.width, height: h)
            self.dayLabel.frame = fr
        })
//        UIView.animateWithDuration(0.5, animations: {
//            self.dayLabelHeightC.priority = 250
//            self.dayLabelLeadingC.priority = 250
//            self.dayLabelWidthC.priority = 250
//            self.layoutIfNeeded()
//        })
//        UIView.animateWithDuration(0.5, animations: {
//            let pippo = self.view.frame.width / 3.5
//            self.dayLabel.frame.origin.x += pippo
//        })
        
        _ = Timeout(1) {
            print(self.dayLabel.frame)
        }
        
    }
    
    func scrollerSetup() {

        yearHandler.callback = callbackPicker
        yearHandler.numbers = yearNumbers
        
        monthHandler.callback = callbackPicker
        monthHandler.numbers = monthNumbers
        
        dayHandler.callback = callbackPicker
        dayHandler.numbers = dayNumbers

        hourHandler.numbers = hourNumbers
        minuteHandler.numbers = minuteNumbers

        scrollerSetupNumbers()
        
    }
    
    func scrollerSetupNumbers() {
        
        yearHandler.initDataCell(popolateNumbers(1, to: 2050))
        dayHandler.initDataCell(popolateDays(self.year, m: self.month))
        monthHandler.initDataCell(popolateMonths())
        hourHandler.initDataCell(popolateNumbers(0, to: 23))
        minuteHandler.initDataCell(popolateNumbers(0, to: 59))

        _ = Timeout(0.1) {
            self.scrollerInitValues()
        }
        
    }
    
    func scrollerInitValues() {
        self.yearHandler.setCurrentElement(self.year)
        self.monthHandler.setCurrentElement(self.month)
        self.dayHandler.setCurrentElement(self.day)
        self.hourHandler.setCurrentElement(self.hour,offset: 1)
        self.minuteHandler.setCurrentElement(self.minute, offset: 1)
    }
    
    func callbackPicker() {
        year = self.yearHandler.getCurrentElement()
        month = self.monthHandler.getCurrentElement()
        day = self.dayHandler.getCurrentElement()
        hour = self.hourHandler.getCurrentElement()
        minute = self.minuteHandler.getCurrentElement()
        
        let maxDay = getMonthDays(year, m: month)
        if (day > maxDay) {
            day = maxDay;
        }
        scrollerSetupNumbers()
   
    }
    
    func popolateNumbers(from:Int, to:Int) -> Array<String> {
        
        var out:Array<String> = [""]
        for index in from...to {
            out.append(String(format: "%02d", index))
        }
        out.append("")
        return out
    }
    
    func popolateMonths() -> Array<String> {
        
        return ["", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC", ""]
        
    }
    
    func popolateDays(y:Int, m:Int) -> Array<String> {
        
        var out:Array<String> = [""]
        for index in 1...getMonthDays(y, m: m) {
            out.append(String(format: "%02d", index))
        }
        out.append("")
        return out
        
    }
    
    func getMonthDays(y:Int, m:Int) -> Int {

        let components = NSDateComponents()
        components.year = y
        components.month = m+1
        components.day = 0
        
        let date = calendar!.dateFromComponents(components)
        let components2 = calendar!.components([.Month, .Day], fromDate: date!)
        
        return components2.day
        
    }
        
}
