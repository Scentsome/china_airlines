//
//  ViewController.swift
//  StackViewDemo
//
//  Created by Michael on 10/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var stackCenterX: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
//        numLabel.layer.cornerRadius = 10
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        numLabel.layer.cornerRadius = numLabel.frame.size.width / 2 
        numLabel.layer.borderWidth = 5
        numLabel.layer.borderColor = UIColor.blue.cgColor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.width > size.height {
            UIView.animate(withDuration: 0.5, animations: {
                self.stackCenterX.constant = 100
            })
            
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                self.stackCenterX.constant = 0
                })
        }
    }

}

