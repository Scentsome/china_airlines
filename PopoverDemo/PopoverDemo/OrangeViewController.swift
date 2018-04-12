//
//  OrangeViewController.swift
//  PopoverDemo
//
//  Created by Michael on 12/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class OrangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func callBlueFunc(_ sender: Any) {
        guard let vc = self.presentingViewController as? ViewController else {return}
        
        vc.test()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("presented in orange ",self.presentedViewController)
        print("presenting in orange ", self.presentingViewController)
    }
}
