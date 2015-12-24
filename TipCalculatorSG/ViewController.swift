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
    
    var lowTip: Double!
    var medTip: Double!
    var highTip: Double!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nil.
        
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

    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        //TODO: read the 3 tip values from the defaults
        
        let lowTip = userDefaults.doubleForKey("low_tip")
        let medTip = userDefaults.doubleForKey("med_tip")
        let highTip = userDefaults.doubleForKey("high_tip")
        
        print("\(lowTip)")
        print("\(medTip)")
        print("\(highTip)")
        
        let lowTitle = Int(lowTip * 100)
        let medTitle = Int(medTip * 100)
        let highTitle = Int(highTip * 100)
        
        //TODO: update the tipSelectorControl with the default tip values
        
        tipControl.setTitle("\(lowTitle)%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(medTitle)%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(highTitle)%", forSegmentAtIndex: 2)

        

//         NSUserDefaults.standardUserDefaults().synchronize()
        
        print("view will appear")
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(3.0, animations: { () ->Void in
            self.FadeLabel.alpha = 1.0
            self.FadeControl.alpha = 1.0
            
            //TO DO: call the values from the settengs page
            
            
            
            

            
        })
    
        
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let myText = billField.text
        let myTip = tipLabel.text
        let myTotal = totalLabel.text
        let selectPer = tipControl.selectedSegmentIndex

    
        
        NSUserDefaults.standardUserDefaults().setObject(myText, forKey: "savedAmt")
        NSUserDefaults.standardUserDefaults().setObject(myTip, forKey: "savedTip")
        NSUserDefaults.standardUserDefaults().setObject(myTotal, forKey: "savedTotal")
        NSUserDefaults.standardUserDefaults().setObject(selectPer, forKey: "myPer")
        
        NSUserDefaults.standardUserDefaults().synchronize()
//
        print("View will disappear")
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
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var tipPercentages = [0.15, 0.2, 0.25]
        
        
        let savedLowTip = defaults.doubleForKey("low_tip")
        let savedMedTip = defaults.doubleForKey("med_tip")
        let savedHighTip = defaults.doubleForKey("high_tip")
        
        if savedLowTip > 0.0 && savedMedTip > 0.0 && savedHighTip > 0.0 {
            
            tipPercentages = [ savedLowTip, savedMedTip, savedHighTip ]
        }
        
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        
        
        tipLabel.text = "$/(tip)"
        totalLabel.text = "$/(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

