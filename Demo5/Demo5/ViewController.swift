//
//  ViewController.swift
//  Demo5
//
//  Created by Michael on 22/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var myQueue = DispatchQueue(label: "com.scentsome")
        myQueue = DispatchQueue.global()
        myQueue.async{
//            for i in 0...20 {
                print("heavy work 1")
//            }
        }
        print("hello")
        myQueue.async {
//            for i in 0...20 {
                print("heavy work 2")
//            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

