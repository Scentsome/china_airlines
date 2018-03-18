//
//  ViewController.swift
//  XcodeTour
//
//  Created by Michael on 17/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var input2: UITextField!
    
    var num : Int = 5
    @IBOutlet weak var label: UILabel!
    
    @IBAction func click(_ sender: Any) {
        
//        label.text = input.text
        
        let str1:String = input.text!
        let str2:String = input2.text!
        let value1:Int? = Int(str1)
        let value2:Int? = Int(str2)
        if value1 != nil && value2 != nil {
            let v1:Int = value1!
            let v2:Int = value2!
            
            label.text =  "\(v1 + v2)"
        }else {
            label.text = "請輸入整數"
        }
        input.text = ""
        input2.text = ""
        
    }
    
    override func awakeFromNib() {
        print("created by Storyboard in view controller")
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

