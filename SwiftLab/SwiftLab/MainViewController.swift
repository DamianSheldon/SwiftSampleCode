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
    
    let syncQueue = DispatchQueue(label: "com.tenneshop.syncQueue")
    let dateformatter = DateFormatter()
    
    var queueSuspendCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(resumeButton)
        configureConstraintsForResumeButton()
        
        dateformatter.dateFormat = "yyyy'-'MM'-'dd hh:mm:ss"
        
        syncQueue.suspend()
        
        queueSuspendCounter += 1
        
        syncQueue.async { [unowned self] in
            let dateString = self.dateformatter.string(from: Date())
            
            print("\(#file)> \(#function)> \(#line) execute time:\(dateString)")
        }
    }
    
    // MARK: Responding to the view events
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // observe keyboard hide and show notifications to resize the text view appropriately
        NotificationCenter.default.addObserver(self,
            selector: #selector(MainViewController.keyboardWillShow(_:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object:nil)
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(MainViewController.keyboardWillHide(_:)),
            name:NSNotification.Name.UIKeyboardWillHide,
            object:nil)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.removeObserver(self,
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)

    }
    
    // MARK: Event Responder
    @objc func respondsToResumeButton() {
        if queueSuspendCounter > 0 {
            queueSuspendCounter -= 1
            
            syncQueue.resume()
        }
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if !(textField.text?.isEmpty)! {
            self.textLabel.text = textField.text
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // MARK: Handle keyboard notification
    @objc func keyboardWillShow(_ notification: Notification)
    {
        /*
        Reduce the size of the text view so that it's not obscured by the keyboard.
        Animate the resize so that it's in sync with the appearance of the keyboard.
        */
        adjustViewByKeyboardState(true, keyboardInfo: (notification as NSNotification).userInfo! as AnyObject?)
    }
    
    @objc func keyboardWillHide(_ notification: Notification)
    {
        /*
        Restore the size of the text view (fill self's view).
        Animate the resize so that it's in sync with the disappearance of the keyboard.
        */
        adjustViewByKeyboardState(false, keyboardInfo: (notification as NSNotification).userInfo! as AnyObject?)
    }
    
    // MARK: Uilities
    func adjustViewByKeyboardState(_ state: Bool, keyboardInfo: AnyObject?)
    {
        
        if state { // Show keyboard
        
            let info = keyboardInfo as! NSDictionary
            let keyboardFrameVal = info.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
            let keyboardFrame = keyboardFrameVal.cgRectValue
            
            let distanceBetweenTextFieldAndScreenBottom = UIScreen.main.bounds.height - (self.textField.frame.maxY - self.view.frame.minY)
            let yOffset = keyboardFrame.height - distanceBetweenTextFieldAndScreenBottom

            
            if yOffset > 0 {
                
                self.view.frame.origin.y -= yOffset
                
            }
            
        } else { // Hide keyboard
            
            self.view.frame.origin.y = 0

        }
    }
    
    // MARK: Private Method
    func configureConstraintsForResumeButton() {
        view.addConstraint(NSLayoutConstraint(item: resumeButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: resumeButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.5, constant: 0))
    }
    
    // MARK: Getter
    lazy var resumeButton: UIButton = {
        
        let resumeButton = UIButton(type: .custom)
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        resumeButton.setTitle("Resume", for: .normal)
        resumeButton.setTitleColor(.black, for: .normal)
        resumeButton.addTarget(self, action: #selector(respondsToResumeButton), for: .touchUpInside)
        
        return resumeButton
    }()
}
