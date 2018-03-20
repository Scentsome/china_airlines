//
//  YellowViewController.swift
//  Demo3
//
//  Created by Michael on 20/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {

    @IBAction func removeView(_ sender: Any) {
        let blueView:UIView? = self.view.viewWithTag(34)
//        blueView?.removeFromSuperview()
      blueView?.isHidden = true
    }
    @IBOutlet weak var whiteView: UIView!
    @IBAction func addView(_ sender: Any) {
        let blueView = UIView()
        blueView.tag = 34
        blueView.frame = CGRect(x: 20, y: 100, width: 120, height: 30)
        blueView.backgroundColor = UIColor.blue
//        whiteView.addSubview(blueView)
        self.view.addSubview(blueView)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        print("began","Yellow Controller")
    }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            print("moved"," Yellow controller")
        }

   

}
