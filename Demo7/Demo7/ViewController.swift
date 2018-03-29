//
//  ViewController.swift
//  Demo7
//
//  Created by Michael on 29/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    func keyboardWasShown(notification: Notification){
        if notification.userInfo != nil {
            let rect:CGRect? = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? CGRect
            if rect != nil {
                let kbSize = rect!.size
                let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
            }
        }
    }
    func keyboardWillBeHidden(notification: Notification) {
        UIView.animate(withDuration: 0.5) { // animation
            let contentInsets: UIEdgeInsets = UIEdgeInsets.zero
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: nil) { (notification) in
            print(notification.userInfo)
            self.keyboardWasShown(notification: notification)
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: nil) { (notification) in
            print(notification.userInfo)
            
            self.keyboardWillBeHidden(notification: notification)
        }
        
        
        
//        inputField.layer.borderWidth = 3.0
//        inputField.layer.borderColor = UIColor.black.cgColor
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

