//
//  ViewController.swift
//  ScrollDatePicker
//
//  Created by Marco Pugliese on 10/01/16.
//  Copyright © 2016 Marco Pugliese. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: Picker!
    @IBAction func buttonClick(sender: AnyObject) {
        datePicker.animateLabels()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

