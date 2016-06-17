//
//  AddViewController.swift
//  CustomKeyBoardDemo
//
//  Created by FengLing on 16/6/17.
//  Copyright © 2016年 lk. All rights reserved.
//

import UIKit


protocol addModelDelegate :NSObjectProtocol{
    
    func addModel(model:Model)
    
}


class AddViewController: UIViewController ,UITextFieldDelegate {

    weak  var delegagte:addModelDelegate?
    
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        // Do any additional setup after loading the view.
    }
    @IBAction func okClick() {
        let typeString = segment.selectedSegmentIndex == 0 ? "1":"2"
        
        var  mo:Model = Model.init()
        
        mo.code = self.codeField.text!
        mo.price = self.priceField.text!
        mo.amount = self.amountField.text!
        mo.date = self.dateField.text!
        mo.type = typeString
        
        print("code == \(self.codeField.text)\n amount == \(self.amountField.text) \n price == \(self.priceField.text) \n segment == \(typeString)")
        self.delegagte?.addModel(mo)

        self.navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func DidBeginEdit(sender: UITextField) {
        
        self.view.endEditing(true)
        
        self.datePicker.hidden = false
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
        self.datePicker.hidden = true;
        
        let date = self.datePicker.date
        
        let dateFormatter = NSDateFormatter.init()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        
        self.dateField.text = dateFormatter.stringFromDate(date)
        
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == self.dateField {
            textField.resignFirstResponder()
            self.datePicker.hidden = false
            return false
        }
        return true
    }
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
