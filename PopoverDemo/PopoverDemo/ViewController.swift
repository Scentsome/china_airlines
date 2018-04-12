//
//  ViewController.swift
//  PopoverDemo
//
//  Created by Michael on 12/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("presented in blue ",self.presentedViewController)
        print("presenting in blue ", self.presentingViewController)
    }
    
    func test(){
        print("presented in blue ",self.presentedViewController)
        print("presenting in blue ", self.presentingViewController)
    }
    @IBAction func presentOrange(_ sender: UIButton) {
        guard var orangeVC = self.storyboard?.instantiateViewController(withIdentifier: "CyanVC") else {return}
        orangeVC.modalPresentationStyle = .popover
        
        
        let popPresentaionVC = orangeVC.popoverPresentationController
        popPresentaionVC?.sourceRect = sender.frame
        popPresentaionVC?.sourceView = self.view
        popPresentaionVC?.permittedArrowDirections = .up
        popPresentaionVC?.delegate = self
        
        
        
        present(orangeVC, animated: true, completion: nil)
    }
    
}

extension ViewController : UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

