 //
//  ViewController.swift
//  TipCalculatorSG
//
//  Created by Sukhrobjon Golibboev on 12/4/15.
//  Copyright © 2015 ccsf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billPicker: UIPickerView!
    @IBOutlet weak var FadeLabel: UILabel!
    @IBOutlet weak var FadeControl: UISegmentedControl!
    
    @IBOutlet weak var splitLabel: UILabel!
    
    
    var lowTip: Float!
    var medTip: Float!
    var highTip: Float!
    

    let Guest = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    
    var numGuests = 1
    var total: Double = 0.0
    var splitAmount = Double(0.0)
    var totalAmount = Double()
    var tipPercentage = 0.0
    var tipPercentages = [0.0]
    // var split = Double(0.0)
    var price = 123.00
    var percentage = 0.12789
    
    
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nil.
        
        billPicker.delegate = self
        billPicker.dataSource = self
        
        self.FadeLabel.alpha = 0
        self.FadeControl.alpha = 1
        
        
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        splitLabel.text = "$0.00"
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        billField.text = defaults.stringForKey("savedAmt")
        tipLabel.text = defaults.stringForKey("savedTip")
        totalLabel.text = defaults.stringForKey("savedTotal")
        tipControl.selectedSegmentIndex = defaults.integerForKey("myPer")
        splitLabel.text = defaults.stringForKey("saveslplit")
        billField.becomeFirstResponder()
        
        
    }

    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateOfCalculation()
       
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        //TODO: read the 3 tip values from the defaults
        
        let lowTip = userDefaults.floatForKey("low_tip")
        let medTip = userDefaults.floatForKey("med_tip")
        let highTip = userDefaults.floatForKey("high_tip")
        
        print("\(lowTip)")
        print("\(medTip)")
        print("\(highTip)")
        
        let lowTitle = roundf(lowTip * 100)
        let medTitle = roundf(medTip * 100)
        let highTitle = roundf(highTip * 100)
        
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
        let myslplit = splitLabel.text

    
        
        NSUserDefaults.standardUserDefaults().setObject(myText, forKey: "savedAmt")
        NSUserDefaults.standardUserDefaults().setObject(myTip, forKey: "savedTip")
        NSUserDefaults.standardUserDefaults().setObject(myTotal, forKey: "savedTotal")
        NSUserDefaults.standardUserDefaults().setObject(selectPer, forKey: "myPer")
        NSUserDefaults.standardUserDefaults().setObject(myslplit, forKey: "savesplit")
        
        NSUserDefaults.standardUserDefaults().synchronize()

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
    
    // TO DO: helper func to operate pickerview
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(Guest[row])
    
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Guest.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
    
        return 1
    
    }
    

    


    @IBAction func onEditingChanged(sender: AnyObject) {
        
        updateOfCalculation()
        
        
    }
    
    func updateOfCalculation(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var tipPercentages = [0.15, 0.20, 0.25]
        
        
        
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
        let split = total / Double(numGuests)
        self.totalAmount = total
        tipLabel.text = formatCurrency(tip)
        totalLabel.text = formatCurrency(total)
        
        
        self.total = total
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        splitLabel.text = "$\(total/Double(self.numGuests))"
        
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        splitLabel.text = String(format: "$%.2f", split)
    }
    
    
    
    //helper function: format the currency amount
    func formatCurrency(amount: Double) -> String {
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        
        
        formatter.numberStyle = .CurrencyStyle
        print(formatter.stringFromNumber(price)) // "$123.44"
        
        return formatter.stringFromNumber(amount as NSNumber)!
        
        
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let numGuests = row + 1
        self.numGuests = numGuests
        updateGuestAmount(Double(self.numGuests))
        splitLabel.text = formatCurrency((totalAmount / Double(numGuests)))
    
    }
    
    func updateGuestAmount(numGuests: Double) {
        splitLabel.text = "$\(self.total/Double(self.numGuests))"
        splitLabel.text = formatCurrency((totalAmount / Double(numGuests)))
        
    }
    

    @IBAction func onSegmentedControlChanged(sender: AnyObject) {
        
        let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.PercentStyle
            print(formatter.stringFromNumber(percentage as NSNumber)! )
            // should show percent formatted
        
        if sender.selectedSegmentIndex == 0 {
            //assign percent selected to the instance variable
            //update the labels
            self.tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        } else if sender.selectedSegmentIndex == 1 {
            print("second selected")
        } else {
            print("third selected")
        }
     }
    
    
}

