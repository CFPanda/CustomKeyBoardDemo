//
//  ViewController.swift
//  CustomKeyBoardDemoSwift
//
//  Created by duanchuanfen on 16/5/27.
//  Copyright © 2016年 duanchuanfen. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    var textField:UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField  = UITextField(frame:CGRectMake(100,100,250,40))
        textField!.borderStyle = UITextBorderStyle.RoundedRect
        textField?.center.x = self.view.center.x;
        
        self.view.addSubview(textField!);
        
        let minkeyBoard = DCFKeyoard(frame:CGRectMake(0, 0,self.view.frame.size.width,216*UIScreen.mainScreen().bounds.size.width/320))
        textField?.delegate = self
        minkeyBoard.textField = textField
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textField!.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.textField!.resignFirstResponder()
       
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
    self.textField?.resignFirstResponder()
        return true
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textField!.resignFirstResponder()
    }


}

