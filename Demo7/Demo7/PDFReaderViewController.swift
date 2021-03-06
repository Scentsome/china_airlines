//
//  PDFReaderViewController.swift
//  Demo7
//
//  Created by Michael on 29/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class PDFReaderViewController: UIViewController {
    
    var item:DocItem?
    @IBOutlet weak var coverLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        coverLabel.text = item?.coverText
        timeLabel.text = item?.timeLabel
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
