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
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var empNoTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var syspwdTextField: UITextField!
    var userData:[String:String] = [:]

    
    @IBAction func loginAction(_ sender: Any) {
        print(NSHomeDirectory())
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
                        
                        
                        
                        let children = doc.xpath("//soap:LoginCheckXMLResult/child::node()",namespaces: ["soap":"http://tempuri.org/"])
                        for child in children {
                            
                            self.userData[child.tagName!] = child.content
                        }
                        print(self.userData)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let context = appDelegate.persistentContainer.viewContext
                        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
                        let newUser = User(entity: entity!, insertInto: context)
                        newUser.cname = self.userData["cname"]
                        newUser.ename = self.userData["ename"]
                        newUser.sitacode = self.userData["sitacode"]
                        newUser.email = self.userData["email"]
                        newUser.code = self.userData["code"]
                        newUser.empno = self.userData["empno"]
                        do {
                            try context.save()
                        } catch {
                            print("Failed saving")
                        }
                        
                        
                        
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
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground , object: nil, queue: nil) { (notification) in
            print("enter background in view controller")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

