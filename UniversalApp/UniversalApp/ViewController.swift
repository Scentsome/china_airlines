//
//  ViewController.swift
//  UniversalApp
//
//  Created by Michael on 07/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var launchSwitch: UISwitch!
    
    @IBAction func launchStoryboard(_ sender: Any) {
        
        if launchSwitch.isOn {
            performSegue(withIdentifier: "toPhoneSegue", sender: sender)
        }else {
            performSegue(withIdentifier: "toPadSegue", sender: sender)
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

