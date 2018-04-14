//
//  ViewController.swift
//  login_ChinaAirline_swift
//
//  Created by cora on 2018/4/11.
//  Copyright © 2018年 cora. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {
    
    @IBOutlet weak var empNoTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var syspwdTextField: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        
        if empNoTextField.text != nil && pwdTextField.text != nil && syspwdTextField.text != nil {
            
            let empNo:String = empNoTextField.text!
            let pwd:String = pwdTextField.text!
            let syspwd:String = syspwdTextField.text!
            let parameters = ["empno":empNo,"pwd":pwd,"syspwd":syspwd]
            
            let soap = Soap(url: "https://tpecr01.china-airlines.com/test/jsonparser/jsonoutput_1/jsonoutput_1/Service1.asmx", parameter: parameters, methodName: "LoginCheckXML", namespace: "http://tempuri.org/")
            
            let request = soap.post12()
            
            Alamofire.request(request).response { (response) in
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {

                    print("Data: \(utf8Text)")
                    
                    do{
                        let doc = try Kanna.XML(xml: data, encoding: .utf8)
                        
                        let resultNode = doc.at_xpath("//soap:result", namespaces: ["soap":"http://tempuri.org/"])
                        
                        if resultNode != nil {
                            let result:String = (resultNode?.text)!
                            
                            print(result)
                            
                            if result == "true" {
                                
                                switch UIDevice.current.userInterfaceIdiom {
                                case .phone:
                                    
                                    self.performSegue(withIdentifier: "toiPhoneSegue", sender: nil)
                                    
                                case .pad:
                                    
                                    self.performSegue(withIdentifier: "toiPadSegue", sender: nil)
                                    
                                default:
                                    break
                                }
                            }
                        }
                    } catch {
                        
                        print("Parser Error")
                    }
                }
            }
        } else {
            
            print("Please check your input :D")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

