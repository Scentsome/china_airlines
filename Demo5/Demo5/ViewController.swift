//
//  ViewController.swift
//  Demo5
//
//  Created by Michael on 22/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import CryptoSwift
import Alamofire
import Reachability

struct JSONData : Codable {
    var key:String
    var one:String
}

class ViewController: UIViewController {
    @IBAction func getMETHOD(_ sender: Any) {
        var urlString = "http://www.apple.com"
//        Alamofire.request(urlString).response { response in
//
//            if response.error != nil {
//                print("error",response.error)
//                return
//            }
//            var html = String(data: response.data!, encoding: .utf8)
//
//            print("\(html)")
//        }
        let jsonURL = "http://echo.jsontest.com/key/value/one/two"
        //   { "key" : "value", "one" : "two" }
//
        Alamofire.request(jsonURL).responseJSON { (response) in
            do {
                let json:JSONData? = try  JSONDecoder().decode(JSONData.self, from: response.data!)
                print(json?.one)
            }catch {
                print(error)
            }
        }
        print("do something.....")
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityChanged(note:)), name: .reachabilityChanged, object: nil)
        
        var myQueue = DispatchQueue(label: "com.scentsome")
        myQueue = DispatchQueue.global()
        myQueue.async{
//            for i in 0...20 {
                print("heavy work 1")
//            }
        }
        print("hello")
        myQueue.async {
//            for i in 0...20 {
                print("heavy work 2")
//            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

