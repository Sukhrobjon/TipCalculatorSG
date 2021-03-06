//
//  PercentageViewController.swift
//  TipCalculatorSG
//
//  Created by Sukhrobjon Golibboev on 12/13/15.
//  Copyright © 2015 ccsf. All rights reserved.
//

import UIKit

class PercentageViewController: UIViewController {

    @IBOutlet weak var tipSelectorControl: UISegmentedControl!
    
    @IBOutlet weak var tipEditorControl: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
        //TODO: read from the user defaults for the 3 tip percentages
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        //TODO: read the 3 tip values from the defaults
        
        var lowTip = userDefaults.floatForKey("low_tip")
        var medTip = userDefaults.floatForKey("med_tip")
        var highTip = userDefaults.floatForKey("high_tip")
        
        if (userDefaults.stringForKey("low_tip") == nil) { lowTip = 0.15 }
        if (userDefaults.stringForKey("med_tip") == nil) { medTip = 0.20 }
        if (userDefaults.stringForKey("high_tip") == nil) { highTip = 0.25 }
        
        print("\(lowTip)")
        print("\(medTip)")
        print("\(highTip)")
        
        let lowTitle = roundf(lowTip * 100)
        let medTitle = roundf(medTip * 100)
        let highTitle = roundf(highTip * 100)
        
        //TODO: update the tipSelectorControl with the default tip values
        
        tipSelectorControl.setTitle("\(lowTitle)%", forSegmentAtIndex: 0)
        tipSelectorControl.setTitle("\(medTitle)%", forSegmentAtIndex: 1)
        tipSelectorControl.setTitle("\(highTitle)%", forSegmentAtIndex: 2)
        
        
        
        NSUserDefaults.standardUserDefaults().setObject(tipSelectorControl.selectedSegmentIndex, forKey: "selected_segment")
        
//        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSUserDefaults.standardUserDefaults().setObject(tipSelectorControl.selectedSegmentIndex, forKey: "selected_segment")
        
    
        
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    
        

        
        print("view did disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tipSelectorChanged(sender: AnyObject) {
    }

    @IBAction func tipEditorChanged(sender: AnyObject) {
        
//        userDefaults.setFloat(round(newFloatValue*100)/100);, forKey:"low_tip")
       
        
        //TODO: update the title of the tip selector 
        // to reflect the new tip amount 
        
        // the tip editor is tipEditorControl.value....
        // the tip selector is tipSelectorControl.text
        
        let newTitle = "\(roundf(tipEditorControl.value))%"
        tipSelectorControl.setTitle(newTitle, forSegmentAtIndex: tipSelectorControl.selectedSegmentIndex)
        
        print(newTitle)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let newFloatValue : Float = roundf(tipEditorControl.value) / 100.0
        
        if (tipSelectorControl.selectedSegmentIndex == 0)
        {
            userDefaults.setFloat(newFloatValue, forKey: "low_tip")
        }
        else if (tipSelectorControl.selectedSegmentIndex == 1)
        {
            userDefaults.setFloat(newFloatValue, forKey: "med_tip")

        }
        else if (tipSelectorControl.selectedSegmentIndex == 2)
        {
            userDefaults.setFloat(newFloatValue, forKey: "high_tip")
        }
        
        func selectSegment() {
            var selectedSegment = NSUserDefaults.standardUserDefaults().stringForKey("selected_segment")
            
            if (selectedSegment == nil) { selectedSegment = "0" }
            
            tipSelectorControl.selectedSegmentIndex = Int(selectedSegment!)!
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
