//
//  SoapRequest.swift
//  zip_upload
//
//  Created by cora on 2018/4/10.
//  Copyright © 2018年 cora. All rights reserved.
//

import Foundation

class Soap:NSObject {
    
    let url: String
    let parameter: Dictionary<String, String>
    let methodName: String
    let namespace: String
    
    init (url:String, parameter:Dictionary<String, String>, methodName:String , namespace:String){
        
        self.url = url
        self.parameter = parameter
        self.methodName = methodName
        self.namespace = namespace
    }
    
    //soap 1.1
    func toSoapMessage11(methodName: String, paramValues: String, namespace: String) -> String {
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
    
    func post11() -> URLRequest {
        
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
        
        let soapMsg: String = toSoapMessage11(methodName: methodName, paramValues: rootCodeStr, namespace: namespace)
        
        urlRequest.setValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(String(soapMsg), forHTTPHeaderField: "Content-Length")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = soapMsg.data(using: String.Encoding.utf8)
        
        return urlRequest
    }
    
    //soap 1.2
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
    
    func post12() -> URLRequest {
        
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
        urlRequest.setValue(String(soapMsg), forHTTPHeaderField: "Content-Length")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = soapMsg.data(using: String.Encoding.utf8)
//        print("soapMsg: ", soapMsg)
        
        return urlRequest
    }
}
