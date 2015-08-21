//
//  DMLMainViewController.swift
//  MyAppWriteWithSwift
//
//  Created by Meiliang Dong on 11/30/14.
//  Copyright (c) 2014 dongmeilianghy@sina.com. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: Responding to the view events
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // observe keyboard hide and show notifications to resize the text view appropriately
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillShow:"),
            name: UIKeyboardWillShowNotification,
            object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("keyboardWillHide:"),
            name:UIKeyboardWillHideNotification,
            object:nil)
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillHideNotification,
            object: nil)

    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if !textField.text.isEmpty {
            self.textLabel.text = textField.text
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // MARK: Handle keyboard notification
    @objc func keyboardWillShow(notification: NSNotification)
    {
        /*
        Reduce the size of the text view so that it's not obscured by the keyboard.
        Animate the resize so that it's in sync with the appearance of the keyboard.
        */
        adjustViewByKeyboardState(true, keyboardInfo: notification.userInfo!)
    }
    
    @objc func keyboardWillHide(notification: NSNotification)
    {
        /*
        Restore the size of the text view (fill self's view).
        Animate the resize so that it's in sync with the disappearance of the keyboard.
        */
        adjustViewByKeyboardState(false, keyboardInfo: notification.userInfo!)
    }
    
    // MARK: Uilities
    func adjustViewByKeyboardState(state: Bool, keyboardInfo: AnyObject?)
    {
        
        if state { // Show keyboard
        
            let info = keyboardInfo as! NSDictionary
            let keyboardFrameVal = info.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
            let keyboardFrame = keyboardFrameVal.CGRectValue()
            
            let distanceBetweenTextFieldAndScreenBottom = CGRectGetHeight(UIScreen.mainScreen().bounds) - (CGRectGetMaxY(self.textField.frame) - CGRectGetMinY(self.view.frame))
            let yOffset = keyboardFrame.height - distanceBetweenTextFieldAndScreenBottom

            
            if yOffset > 0 {
                
                self.view.frame.origin.y -= yOffset
                
            }
            
        } else { // Hide keyboard
            
            self.view.frame.origin.y = 0

        }
    }
    
}