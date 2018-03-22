//
//  SelectViewController.swift
//  Demo5
//
//  Created by Michael on 22/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

protocol SelectViewControllerDelegate {
    func selectVC(_ select:SelectViewController, with date:Date )
}

class SelectViewController: UIViewController {
    var delegate:SelectViewControllerDelegate?
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func backToHome(_ sender: Any) {
        delegate?.selectVC(self, with: datePicker.date)
        print(datePicker.date)
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
