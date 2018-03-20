//
//  LoginViewController.swift
//  Demo3
//
//  Created by Michael on 20/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var accountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountField.delegate = self
    }

    @IBAction func login(_ sender: Any) {
        
        let alert = UIAlertController(title: "Error", message: "password failed", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension LoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.accountField {
            print("account begin editing")
        }
        
        if textField == self.passwordField {
            print("password begin editing")
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text)
        return true
    }
}



