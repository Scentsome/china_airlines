//
//  ViewController.swift
//  LoginDemo
//
//  Created by Michael on 14/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {
    @IBOutlet weak var empNoTextfield: UITextField!
    
    @IBOutlet weak var pwdTextfield: UITextField!
    
    @IBOutlet weak var syspwdTextfield: UITextField!
    
    
    @IBAction func login(_ sender: Any) {
        
        if empNoTextfield.text! != "" && pwdTextfield.text! != "" && syspwdTextfield.text! != "" {
            
            let empNo:String = empNoTextfield.text!
            let pwd:String = pwdTextfield.text!
            let syspwd:String = syspwdTextfield.text!
            let parameters = ["empno":empNo,"pwd":pwd,"syspwd":syspwd]
            
            let soap = Soap(url: "https://tpecr01.china-airlines.com/test/jsonparser/jsonoutput_1/jsonoutput_1/Service1.asmx", parameter: parameters, methodName: "LoginCheckXML", namespace: "http://tempuri.org/")
            
            let request = soap.post12()

//            print(String(data: request.httpBody!, encoding: String.Encoding.utf8))
            Alamofire.request(request).response { (response) in
                if let data = response.data, let utf8Text = String(data: data,encoding: .utf8) {
                    print("Data: \(utf8Text)")
                    
                    do{
                        let doc = try Kanna.XML(xml: data, encoding: .utf8)
                        let resultNode = doc.at_xpath("//ns:result",namespaces: ["ns":"http://tempuri.org/"])
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

        }else {
            
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


}

