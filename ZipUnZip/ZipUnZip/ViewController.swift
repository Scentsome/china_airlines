//
//  ViewController.swift
//  ZipUnZip
//
//  Created by Michael on 31/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import Zip

class ViewController: UIViewController {

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getResults()
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

