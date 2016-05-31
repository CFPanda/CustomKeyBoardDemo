//
//  DCFKeyoard.swift
//  CustomKeyBoardDemoSwift
//
//  Created by duanchuanfen on 16/5/27.
//  Copyright © 2016年 duanchuanfen. All rights reserved.
//

import UIKit

protocol DCFKeyboardDelegate:class{
    func numericKeyDidPressed(key:Int)
    func backspaceKeyDidPressed()
}


class DCFKeyoard: UIView {
    var textField:UITextField?{
        willSet{
            print("willSet");
        }
        didSet{
            
            self.textField!.inputView = self
            self.textInputDelegate = self.textField!

           print("didSet"); 
        }
    }
    
    var style:NSString?
    weak var textInputDelegate:UITextInput!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.defaultInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //添加按键
    func defaultInit(){
        self.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(self.addNumericKeyWithTitle("1", frame: CGRectMake(0,1*SCALE,105*SCALE,53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle("2",frame:
            CGRectMake(106*SCALE,1*SCALE,108*SCALE,53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle("3", frame: CGRectMake(215*SCALE,1*SCALE,106*SCALE,53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle("4",frame:
            CGRectMake(0, 55*SCALE, 105*SCALE, 53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle("5", frame: CGRectMake(106*SCALE, 55*SCALE, 108*SCALE, 53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle("6",frame:
            CGRectMake(215*SCALE,55*SCALE, 105*SCALE, 53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle("7", frame: CGRectMake(0, 109*SCALE, 105*SCALE, 53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle("8",frame:
            CGRectMake(106*SCALE, 109*SCALE, 108*SCALE , 53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle("9", frame: CGRectMake(215*SCALE, 109*SCALE, 108*SCALE, 53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle(".",frame:
                CGRectMake(0*SCALE, 163*SCALE, 105*SCALE, 53*SCALE)))
        self.addSubview(self.addNumericKeyWithTitle("0", frame: CGRectMake(106*SCALE, 163*SCALE, 108*SCALE, 53*SCALE)))
        self.addSubview(self.addBackspaceKeyWithFrame(CGRectMake(215*SCALE, 163*SCALE, 105*SCALE, 53*SCALE)))
    }
    
    
    //创建按键函数
    func addNumericKeyWithTitle(title:NSString,frame:CGRect)->UIButton{
        let button = UIButton(type:UIButtonType.Custom)
        button.frame = frame
        button.setTitle(title as String, forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(20.0)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        button.setTitleShadowColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        button.setTitleShadowColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        button.titleLabel?.shadowOffset = CGSizeMake(0, -0.5)
        
        let  buttonImage = UIImage(named: "KeyboardNumericEntryKeyTextured")
        let  buttonPressedImage = UIImage(named: "KeyboardNumericEntryKeyPressedTextured")
        button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        button.setBackgroundImage(buttonPressedImage, forState: UIControlState.Highlighted)
        button.addTarget(self, action: "pressNumericKey:", forControlEvents: UIControlEvents.TouchUpInside)
        return button
        
    }
    
    //创建删除按钮
    func addBackspaceKeyWithFrame(frame:CGRect)->UIButton{
        let button = UIButton(type:UIButtonType.Custom)
        button.frame = frame
        let  buttonImage = UIImage(named: "KeyboardNumericEntryKeyTextured")
        let  buttonPressedImage = UIImage(named: "KeyboardNumericEntryKeyPressedTextured")
        let  image = UIImage(named: "KeyboardNumericEntryKeyBackspaceGlyphTextured")
        let imageView = UIImageView(frame: CGRectMake((buttonImage!.size.width-image!.size.width)/2, (buttonImage!.size.height-image!.size.height)/2, image!.size.width, image!.size.height))
        imageView.image = image
        button.addSubview(imageView)
        button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        button.setBackgroundImage(buttonPressedImage, forState: UIControlState.Highlighted)
        button.addTarget(self, action: "pressBackspaceKey", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    
    func pressNumericKey(button:UIButton){
        let keyText:NSString = button.titleLabel!.text!
        var  key:Int32 = -1;
        
        if ("." as NSString).isEqualToString(keyText as String )
        {
            key = 10}
        else
        {
            key = keyText.intValue
        }
        
        //判断有没有小数点
        let dot:NSRange = ((self.textField?.text)! as NSString).rangeOfString(".")

        switch key {
            case 10:
            if dot.location == NSNotFound && self.textField?.text?.characters.count == 0{
                self.textInputDelegate.insertText("0.")
            }else if dot.location == NSNotFound{
                self.textInputDelegate.insertText(".")
            }
            
        default:
             if dot.location == NSNotFound || self.textField?.text?.characters.count <= dot.location + 2{
                self.textInputDelegate.insertText(NSString(format: "%d",key) as String)
            }
            
        }
        
    }
    
    //点击删除按钮
    func  pressBackspaceKey() {
        if ("0." as NSString).isEqualToString(((self.textField?.text)! as String)) {
            
            self.textField?.text = ""
            return
        } else {
            self.textInputDelegate.deleteBackward()
        }
        
     }
}
