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
        scrollerSetup()
        
        let components = calendar!.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: date)
        day = components.day
        month = components.month
        year = components.year
        hour = components.hour
        minute = components.minute
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
        
    }
    
    func scrollerSetup() {
        
        yearNumbers.initDataCell(popolateNumbers(1, to: 2050), identifier: "YearNumbersCell")
        yearNumbers.callback = callbackPicker
        dayNumbers.initDataCell(popolateDays(self.year, m: self.month), identifier: "DayNumbersCell")
        dayNumbers.callback = callbackPicker
        monthNumbers.initDataCell(popolateMonths(), identifier: "MonthNumbersCell")
        monthNumbers.callback = callbackPicker
        hourNumbers.initDataCell(popolateNumbers(0, to: 23), identifier: "HourNumbersCell")
        minuteNumbers.initDataCell(popolateNumbers(0, to: 59), identifier: "MinuteNumbersCell")

        _ = Timeout(0.1) {
            self.scrollerInitValues()
        }
        
    }
    
    func scrollerInitValues() {
        self.dayNumbers.setCurrentElement(self.day)
        self.monthNumbers.setCurrentElement(self.month)
        self.yearNumbers.setCurrentElement(self.year)
        self.hourNumbers.setCurrentElement(self.hour,offset: 1)
        self.minuteNumbers.setCurrentElement(self.minute, offset: 1)
    }
    
    func callbackPicker() {
        year = self.yearNumbers.getCurrentElement()
        month = self.monthNumbers.getCurrentElement()
        day = self.dayNumbers.getCurrentElement()
        hour = self.hourNumbers.getCurrentElement()
        minute = self.minuteNumbers.getCurrentElement()
        
        let maxDay = getMonthDays(year, m: month)
        if (day > maxDay) {
            day = maxDay;
        }
        scrollerSetup()
   
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
        
        return ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", ""]
        
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
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
