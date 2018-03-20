//
//  ViewController.swift
//  Demo3
//
//  Created by Michael on 20/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol ViewControllerDelegate {
    func didSendData(_ viewController:ViewController, withData data:String)
}


class ViewController: UIViewController {
    @IBOutlet weak var input1: UITextField!
    lazy  var rects:Array<String>? = Array<String>()
//    var manager = CLLocationManager()
//    var annotation = MKAnnotation()
    @IBOutlet weak var textField: UITextField!
    //  override func loadView() {
    
  //  }
    
    @IBAction func showVCOnThird(_ sender: Any) {
//        if rects == nil {
//            rects = Array<String>()
//        }
        
//        rects.
        
        
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
        
        input1.delegate = self
//        textField.becomeFirstResponder()
//        self.becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
//        textField.becomeFirstResponder()
        self.becomeFirstResponder()
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        textField.resignFirstResponder()
        
        view.endEditing(true)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("moved","view  controller")
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Shake event handler")
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

