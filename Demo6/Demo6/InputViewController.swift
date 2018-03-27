//
//  InputViewController.swift
//  Demo6
//
//  Created by Michael on 27/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    var closureObject: ((String) -> Void)?
    var stringData = ""
//    var homeVC:ViewController?
    @IBAction func backToHome(_ sender: Any) {
        if closureObject != nil {
            closureObject!(inputField.text!)
        }
    self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Input"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
