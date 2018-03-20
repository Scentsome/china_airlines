//
//  ViewController.swift
//  Demo3
//
//  Created by Michael on 20/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  //  override func loadView() {
    
  //  }
    
    @IBAction func showVCOnThird(_ sender: Any) {
        
        let thirdBoard = UIStoryboard(name: "Third", bundle: nil)
        
//        let vc = ViewController()
        var vc:UIViewController? =  thirdBoard.instantiateInitialViewController()
//        vc = thirdBoard.instantiateViewController(withIdentifier: "WhiteVC")
        
        
        if vc != nil {
            present(vc!, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        print(segue.destination)
        print(segue.source)
        
        
        
    }
    
    @IBAction func home(segue:UIStoryboardSegue){
        print("back to home")
        print(segue.destination)
        print(segue.source)
    }


}

