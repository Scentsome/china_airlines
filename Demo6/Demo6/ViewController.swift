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
    
    
    @IBAction func compose(_ sender: Any) {
        
        print("compose....")
    }
    
    
    @IBAction func showYellow(_ sender: Any) {
        let yellowVC = self.storyboard?.instantiateViewController(withIdentifier: "YellowVC")
        
        
        self.addChildViewController(yellowVC!)
        
        self.transition(from: self.childViewControllers[0], to: yellowVC!, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromBottom, animations: nil) { (finished) in
            yellowVC?.didMove(toParentViewController: self)
        }
    }
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
        self.navigationController?.pushViewController(realVC, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.childViewControllers)
        self.title = "Main"
        
        let leftButton = UIBarButtonItem(title: "Record", style: UIBarButtonItemStyle.plain, target: self, action:#selector(ViewController.sayHello(sender:)))
        
        self.navigationItem.leftBarButtonItem = leftButton
        
        
        var backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem  = backButton
//        self.navigationItem.rightBarButtonItem
        
//        self.tabBarItem.title = "Tab1"
//        self.navigationController?.tabBarItem.title = "Tab1"
    }
    @objc func sayHello(sender:UIBarButtonItem){
        print("Hello.....")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

