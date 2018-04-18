//
//  ViewController.swift
//  CustomizeTransition
//
//  Created by Michael on 18/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var secondField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        firstTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        firstTextField.frame = CGRect(x:93, y:86, width:220, height:30)
        UIView.animate(withDuration: 1.0) {
            self.firstTextField.frame = CGRect(x:93, y:86, width:186, height:30)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
    }

    @IBAction func backHome(segue:UIStoryboardSegue) {
        
    }

}

extension ViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ShrinkController()
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(textField.text)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text)
        
        if textField == firstTextField {
            if textField.text?.count == 6 {
                self.secondField.becomeFirstResponder()
            }
        }
        if textField == secondField {
            
        }

        
        return true
    }
}



