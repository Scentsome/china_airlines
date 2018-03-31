//
//  ViewController.swift
//  Demo8
//
//  Created by Michael on 31/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    
    
    var array = ["Coffee","Milk","Juice"]
    var webKitView:WKWebView = WKWebView()

    @IBAction func inject(_ sender: Any) {
//        webKitView.evaluateJavaScript(" function changeColorNav(){  var nav = getElementById(\"ac-globalfooter\"); nav.style.backgroundColor = \"coral\" ;}  changeColorNav(); ", completionHandler: nil)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
            
            if let oriJSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                let string = oriJSONString.replacingOccurrences(of: "\n", with: "")
                let trimmed = string.replacingOccurrences(of: " ", with: "")
                
                let javaScriptString = "createList('\(trimmed)');"
                
                webKitView.evaluateJavaScript(javaScriptString, completionHandler: nil)
                
            }
        } catch {
            print(error)
        }

    }

    func addJSObserver(){
        
        let config = WKWebViewConfiguration()
        let controller = WKUserContentController()
        controller.add(self, name: "wkMessage")
        config.userContentController = controller
        let frame = CGRect(x:0, y:100, width:view.bounds.width, height:view.bounds.height-100)
        webKitView = WKWebView(frame: frame, configuration: config)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addJSObserver()
        
        let filePath = Bundle.main.path(forResource: "hello", ofType: "html")
        let localURL = URL(fileURLWithPath: filePath!)
//        guard let remoteURL = URL(string:"http://www.apple.com") else {
//            return
//        }
        let request = URLRequest(url: localURL)
        webKitView.load(request)
        
        self.view.addSubview(webKitView)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NextVC") else {
            return 
        }
        present(nextVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

