//
//  ViewController.swift
//  Demo6
//
//  Created by Michael on 27/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    
    
    func changeLabel(data:String) -> Void{
        self.myLabel.text = data
    }
    @IBAction func showNext(_ sender: Any) {
        let inputVC:InputViewController? =  self.storyboard?.instantiateViewController(withIdentifier: "InputVC") as? InputViewController
//        let changeObject:(String) -> Void = { (data:String) -> Void in
//            self.myLabel.text = data
//        }
//        inputVC?.homeVC = self
        inputVC?.closureObject = { (data:String) -> Void in
            self.myLabel.text = data
        }
        inputVC?.stringData = "1234"
        
        if let realVC = inputVC {
//            present(realVC, animated: true, completion: nil)
//            self.navigationController?.pushViewController(realVC, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main"
//        self.navigationItem.rightBarButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

