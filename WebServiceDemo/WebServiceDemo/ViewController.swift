//
//  ViewController.swift
//  WebServiceDemo
//
//  Created by Michael on 31/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import Alamofire
import Kanna
import Zip

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryByIP()
        zipTheCatPhoto(imgName: "port80.jpg", zipName: "port.zip")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCountryByIP() {
        
        let parameters:[String:String] = [:]
        
        let urlRequest = soapRequest12(url: "http://tpeweb02.china-airlines.com/webfz/services/ListbyFdateMainService.ListbyFdateMainServiceHttpSoap12Endpoint/",parameter: parameters,
                                       methodName: "getRankCode",
                                       namespace: "http://MsgFromGrd.ws")
        
        Alamofire.request(urlRequest).response { (response) in
            
            if let data = response.data, let utf8Text = String(data: data,encoding: .utf8) {
                print("Data: \(utf8Text)")
                do {
                    let doc = try Kanna.XML(xml: data, encoding: .utf8)
                    print("Doc: \(doc)")
                    
                    for node in doc.xpath("//ns:return", namespaces: ["ns": "http://MsgFromGrd.ws"]) {
                        print(node.text!)
                        
//                        self.rankCodeArr.append(node.text!)
                    }
//                    print(self.rankCodeArr)
//                    self.tableView.reloadData()
                    
                } catch {
                    print("Error")
                }
            }
        }
    }
    func toSoapMessage12(methodName: String, paramValues: String, namespace: String) -> String {
        var message: String = String()
        message += "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        message += "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
        message += "<soap12:Body>"
        message += "<\(methodName) xmlns=\"\(namespace)\">"
        message += "\(paramValues)"
        message += "</\(methodName)>"
        message += "</soap12:Body>"
        message += "</soap12:Envelope>"
        return message
    }
    
    func soapRequest12(url:String, parameter:Dictionary<String, String>, methodName:String , namespace:String) -> URLRequest {
        let URL = NSURL(string: url)!
        var urlRequest: URLRequest = URLRequest(url:URL as URL)
        var rootCodeStr = ""
        
        if parameter != ["":""] {
            for dic in parameter {
                rootCodeStr += "<"
                rootCodeStr += dic.key
                rootCodeStr += ">"
                rootCodeStr += dic.value
                rootCodeStr += "</"
                rootCodeStr += dic.key
                rootCodeStr += ">"
            }
        }
        let soapMsg: String = toSoapMessage12(methodName: methodName, paramValues: rootCodeStr, namespace: namespace)
        urlRequest.setValue("application/soap+xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //        mutableURLRequest.setValue(action, forHTTPHeaderField: "SOAPAction")
        urlRequest.setValue(String(soapMsg), forHTTPHeaderField: "Content-Length")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = soapMsg.data(using: String.Encoding.utf8)
        print("soapMsg: ", soapMsg)
        return urlRequest
    }

    func zipTheCatPhoto(imgName: String, zipName: String) {
        
        let image = UIImage(named:imgName)
        let imageData: Data = UIImageJPEGRepresentation(image!, 1.0)!
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imgName)
        
        do {
            try imageData.write(to: docUrl)
            
            
        } catch {
            print("Write Data Error")
            print(error.localizedDescription)
        }
        
        do {
            let zipFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(zipName)
            print(zipFilePath)
            try Zip.zipFiles(paths: [docUrl], zipFilePath: zipFilePath, password: nil, progress: { (progress) -> () in
                print(progress)
                
            }) //Zip
        }
        catch {
            print("Something went wrong")
        }
    }
    
    func requestUploadFile() {
        
        //        let image = UIImage(named:"robot")
        let zipFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("port.zip")
        
        do {
            let jpgZip:Data? = try Data(contentsOf: URL(fileURLWithPath: zipFilePath.absoluteString))
            if let data = jpgZip {
                
                let parameters = ["data": String(data: data, encoding: .utf8)! ]
                
                let urlRequest = soapRequest12(url: "http://202.165.148.120/webfz/services/ListbyFdateMainService?wsdl", parameter: parameters, methodName: "saveFile", namespace: "http://MsgFromGrd.ws")
                
                Alamofire.request(urlRequest).response { (response) in
                    
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        
                        print("Data: \(utf8Text)")
                    }
                }
            }
            
        } catch {
            print(error)
        }
    }

}

