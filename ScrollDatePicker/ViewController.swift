//
//  ViewController.swift
//  ScrollDatePicker
//
//  Created by Marco Pugliese on 10/01/16.
//  Copyright © 2016 Marco Pugliese. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var pickerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _ = ScrollDatePicker(container_view: pickerView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

