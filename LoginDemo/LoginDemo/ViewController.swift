//
//  ViewController.swift
//  LoginDemo
//
//  Created by Michael on 14/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var empNoTextfield: UITextField!
    
    @IBOutlet weak var pwdTextfield: UITextField!
    
    @IBOutlet weak var syspwdTextfield: UITextField!
    
    
    @IBAction func login(_ sender: Any) {
        
        if empNoTextfield.text! != "" && pwdTextfield.text! != "" && syspwdTextfield.text! != "" {
            
        }else {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

