 //
//  ViewController.swift
//  TipCalculatorSG
//
//  Created by Sukhrobjon Golibboev on 12/4/15.
//  Copyright © 2015 ccsf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var FadeLabel: UILabel!
    @IBOutlet weak var FadeControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.FadeLabel.alpha = 0
        self.FadeControl.alpha = 1
        
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        billField.text = defaults.stringForKey("savedAmt")
        tipLabel.text = defaults.stringForKey("savedTip")
        totalLabel.text = defaults.stringForKey("savedTotal")
        tipControl.selectedSegmentIndex = defaults.integerForKey("myPer")
        billField.becomeFirstResponder()
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(3.0, animations: { () ->Void in
            self.FadeLabel.alpha = 1.0
            self.FadeControl.alpha = 1.0
            
        })
    
        
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("View will disappear")
        let myText = billField.text
        let myTip = tipLabel.text
        let myTotal = totalLabel.text
        let selectPer = tipControl.selectedSegmentIndex
    
    
        
        
        NSUserDefaults.standardUserDefaults().setObject(myText, forKey: "savedAmt")
        NSUserDefaults.standardUserDefaults().setObject(myTip, forKey: "savedTip")
        NSUserDefaults.standardUserDefaults().setObject(myTotal, forKey: "savedTotal")
        NSUserDefaults.standardUserDefaults().setObject(selectPer, forKey: "myPer")
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("View did disappear")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    


    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.15, 0.2, 0.25]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        
        
        tipLabel.text = "$/(tip)"
        totalLabel.text = "$(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

