//
//  ViewController.swift
//  WebViewInteraction
//
//  Created by Michael on 29/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {
    @IBOutlet var webView:WKWebView!
    var array = ["Coffee","Milk","Juice"]

    @IBAction func inject(_ sender: Any) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
            
            if let oriJSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                let string = oriJSONString.replacingOccurrences(of: "\n", with: "")
                let trimmed = string.replacingOccurrences(of: " ", with: "")
                
                let javaScriptString = "createList('\(trimmed)');"
                
            webView.evaluateJavaScript(javaScriptString, completionHandler: nil)
                
            }
        } catch {
            print(error)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let config = WKWebViewConfiguration()
        let controller = WKUserContentController()
        controller.add(self, name: "wkMessage")
        config.userContentController = controller
        
        webView = WKWebView(frame: CGRect(x:0, y:100, width:view.bounds.width, height:view.bounds.height-100), configuration: config)
        
        
        
        
        self.view.addSubview(webView)
        
        
        let filePath = Bundle.main.path(forResource: "hello", ofType: "html")
        let localURL = URL(fileURLWithPath: filePath!)
        let request = URLRequest(url: localURL)
        webView.load(request)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let string:NSString? = message.body as? NSString

        print(string)
    }
    
    
}

