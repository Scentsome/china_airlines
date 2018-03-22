//
//  InfoViewController.swift
//  Demo5
//
//  Created by Michael on 22/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import MapKit
class InfoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var map: MKMapView!
    
    var infoTitle:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = infoTitle
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
