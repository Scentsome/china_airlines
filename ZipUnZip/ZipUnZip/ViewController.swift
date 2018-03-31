//
//  ViewController.swift
//  ZipUnZip
//
//  Created by Michael on 31/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import Zip
import Kanna

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var cityNames:[String] = []
    var cityTemps:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        getResults()
//        getXMLResults()
        xml2Struct()
    }
    func getXMLResults(){
        dataTask?.cancel()
        // 25.105497, 121.597366
        if var urlComponents = URLComponents(string: "http://api.openweathermap.org/data/2.5/find?lat=25.105497&lon=121.597366&cnt=10&mode=xml"+"&units=metric"+"&APPID=244c14ab5e489cb4158647df6ee310b2") {
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    print(error.localizedDescription)
                    
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
//                    let utf8Text = String(data: data, encoding: .utf8)
//                    print("Data: \(utf8Text)")
                    if let doc = try? Kanna.XML(xml: data, encoding: .utf8) {
                        
                        for node in doc.xpath("//city/@name") {
                            print(node.text!)
                            
                            self.cityNames.append(node.text!)
                        }
                        
                        for node in doc.xpath("//temperature/@value") {
                            print(node.text!)
                            
                            self.cityTemps.append(node.text!)
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                }
            }
            dataTask?.resume()
        }

    }
    func xml2Struct(){
        guard let xmlFilePath = Bundle.main.path(forResource: "item", ofType: "xml") else {
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath:xmlFilePath))
            let xmlDoc = try Kanna.XML(xml: data, encoding: String.Encoding.utf8)
            var item = Item(title: "", link:"", description:"")
            for node in xmlDoc.xpath("/item/title") {
                item.title = node.text!
            }
            for node in xmlDoc.xpath("/item/link") {
                item.link = node.text!
            }
            for node in xmlDoc.xpath("/item/description") {
                item.description = node.text!
            }
            
            print(item)
            
            
        }catch {
            
        }
        
    }
    
    func getResults() {
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://www.moeasmea.gov.tw/dl.asp?filename=791210302371.zip") {
            
        guard let url = urlComponents.url else {
            return }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer {
                self.dataTask = nil
                
            }
            
            if let error = error {
                print(error.localizedDescription)
                
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                // store in michael's desktop
//                let fileManager = FileManager.default
//                let docUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("file.zip")
                let docUrl = URL(fileURLWithPath: "/Users/michael/Desktop/tmp/file.zip")
                let unzipDocUrl = URL(fileURLWithPath: "/Users/michael/Desktop/tmp/files")
                

                do {
                    try data.write(to: docUrl)
                    
                    try! FileManager.default.createDirectory(atPath: unzipDocUrl.path, withIntermediateDirectories: true, attributes: nil)
                    try Zip.unzipFile(docUrl, destination: unzipDocUrl, overwrite: true,password: nil, progress: { (progress) -> () in
                        print(progress)
                    })

                    
                } catch {
                    print("Write Data Error")
                    print(error.localizedDescription)
                }

            }
        }
        dataTask?.resume()
    }
        
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "XMLCell")
        
        cell?.textLabel?.text = cityNames[indexPath.row]
        cell?.detailTextLabel?.text = cityTemps[indexPath.row]
        return cell!
    }
    
    
}

