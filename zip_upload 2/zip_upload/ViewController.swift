//
//  ViewController.swift
//  zip_upload
//
//  Created by cora on 2018/3/20.
//  Copyright © 2018年 cora. All rights reserved.
//

import UIKit
import Alamofire
import Zip

class ViewController: UIViewController {
    
    let fileManager = FileManager.default
    var imageName = "robot.jpg"
    var zippedName = "archive.zip"
    var zipFilePath:URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        zipTheCatPhoto(imgName: imageName, zipName: zippedName)
//        getRankCode()
        
//        requestUploadFile()
        requestSaveFile(filename:zippedName, filedsc:"cat in zip", zipPath:zipFilePath)
//        requestSaveFile2(filename:zippedName, filedsc:"", zipPath:zipFilePath)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func zipTheCatPhoto(imgName: String, zipName: String) {
        
        let image = UIImage(named:imgName)
        let imageData: Data = UIImageJPEGRepresentation(image!, 1.0)!
        
        let docUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imgName)
        
        do {
            try imageData.write(to: docUrl)
        } catch {
            print("Write Data Error")
            print(error.localizedDescription)
        }
        
        do {
            zipFilePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(zipName)
            try Zip.zipFiles(paths: [docUrl], zipFilePath: zipFilePath, password: nil, progress: { (progress) -> () in
                print(progress)
            }) //Zip
        }
        catch {
            print("Something went wrong")
        }
    }

    
    func getRankCode() {
        
        //        http://tpeweb02.china-airlines.com/webfz/services/ListbyFdateMainService/getRankCode
        // soap:Address  http://tpeweb02.china-airlines.com/webfz/services/ListbyFdateMainService.ListbyFdateMainServiceHttpSoap11Endpoint
        
        let parameters = ["":""]/////
        
        let urlRequest = soapRequest12(url: "http://tpeweb02.china-airlines.com/webfz/services/ListbyFdateMainService.ListbyFdateMainServiceHttpEndpoint/", parameter: parameters, methodName: "getRankCode", namespace: "http://MsgFromGrd.ws")
        
        Alamofire.request(urlRequest).response { (response) in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                
                
                print("Data: \(utf8Text)")
                
                //                self.xml = utf8Text
                //
                //                do {
                //                    let doc = try Kanna.XML(xml: self.xml, encoding: .utf8)
                //                    print("Doc: \(doc)")
                //
                //                    for node in doc.xpath("//w:HelloWorldResult", namespaces: ["w": "http://10.0.1.124:8080/"]) {
                //                        print(node.text!)
                //
                //                    }
                //
                //                    let node = doc.at_xpath("//HelloWorldResult")
                //                    print("Node: \(String(describing: node?.text!))")
                //
                //                } catch {
                //                }
            }
        }
        
    }
    

    
    func requestSaveFile(filename:String, filedsc:String, zipPath:URL) {
        
        var data:Data = Data()
        do {
            data = try Data(contentsOf: zipPath)
        } catch {
            print("Error")
        }
        
        let caFile = ["filedsc":filedsc,
                      "filename":filename,
                      "fltd":"",
                      "sect":"",
                      "upddate":"",
                      "upduser":"",
                      "zipfile":data.base64EncodedString()]
        
        var caFileStr = ""

        for dic in caFile {
            caFileStr += "<"
            caFileStr += dic.key
            caFileStr += ">"
            caFileStr += dic.value
            caFileStr += "</"
            caFileStr += dic.key
            caFileStr += ">"
        }
        
        let parameters = ["file":caFileStr,
                          "sysPwd":"iOS888"]
        
        let urlRequest = soapRequest12(url: "http://202.165.148.120/webfz/services/ListbyFdateMainService?wsdl", parameter: parameters, methodName: "saveFile", namespace: "http://MsgFromGrd.ws")
        
        Alamofire.request(urlRequest).response { (response) in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                
                print("Data: \(utf8Text)")
            }
        }
    }
    
    //soap 1.1
    func toSoapMessage(methodName: String, paramValues: String, namespace: String) -> String {
        var message: String = String()
        message += "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        message += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        message += "<soap:Body>"
        message += "<\(methodName) xmlns=\"\(namespace)\">"//http://xxx/webservices/ 是Webservice的namespace
        message += "\(paramValues)"
        message += "</\(methodName)>"
        message += "</soap:Body>"
        message += "</soap:Envelope>"
        return message
    }
    
    func soapRequest(url:String, parameter:Dictionary<String, String>, methodName:String , namespace:String) -> URLRequest {
        
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
        
        let soapMsg: String = toSoapMessage(methodName: methodName, paramValues: rootCodeStr, namespace: namespace)
        
        urlRequest.setValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //        mutableURLRequest.setValue(action, forHTTPHeaderField: "SOAPAction")
        urlRequest.setValue(String(soapMsg), forHTTPHeaderField: "Content-Length")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = soapMsg.data(using: String.Encoding.utf8)
        
        
        print("soapMsg: ", soapMsg)
        return urlRequest
    }
    
    //soap 1.2
    func toSoapMessage12(methodName: String, paramValues: String, namespace: String) -> String {
        var message: String = String()
        message += "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        message += "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
        message += "<soap12:Body>"
        message += "<\(methodName) xmlns=\"\(namespace)\">"//http://xxx/webservices/ 是Webservice的namespace
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
    
}

class CAFile {
    
    var filedsc:String = "";
    var filename:String = "";
    var fltd:String = "";
    var sect:String = "";
    var upddate:String = "";
    var upduser:String = "";
    var zipfile:String = "";
    
    init(filedsc: String, filename: String, fltd: String, sect:String, upddate:String, upduser:String, zipfile:String) {
        self.filedsc = filedsc
        self.filename = filename
        self.fltd = fltd
        self.sect = sect
        self.upddate = upddate
        self.upduser = upduser
        self.zipfile = zipfile
    }
}

