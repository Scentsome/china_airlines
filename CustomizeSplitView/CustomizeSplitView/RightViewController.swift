//
//  RightViewController.swift
//  CustomizeSplitView
//
//  Created by Michael on 08/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
    

    @IBOutlet weak var dataLabel: UILabel!
    
    func updateLabel(byData:String) {
        dataLabel.text = byData
    }
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

}
