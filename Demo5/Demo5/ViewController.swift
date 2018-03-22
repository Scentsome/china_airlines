//
//  ViewController.swift
//  Demo5
//
//  Created by Michael on 22/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import CryptoSwift
import Alamofire
import Reachability

struct JSONData : Codable {
    var key:String
    var one:String
}

class ViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    
    var libraries:[Item]?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func logout(_ sender: Any) {
        
        var userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "password")
        
        userDefaults.synchronize()
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        
        present(loginVC!, animated: true, completion: nil)
        
    }
    
    
    func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any] ){
        let url = endUrl
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        print("Error in upload:" )
                        return
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
            }
        }
    }
    @IBAction func uploadImage(_ sender: Any) {
        
        let imageData = UIImagePNGRepresentation(UIImage(named:"phone.png")!)
        requestWith(endUrl: "http://localhost:8080/upload", imageData: imageData, parameters: [:])
    }
    
    @IBAction func getMETHOD(_ sender: Any) {
        var urlString = "http://www.apple.com"
//        Alamofire.request(urlString).response { response in
//
//            if response.error != nil {
//                print("error",response.error)
//                return
//            }
//            var html = String(data: response.data!, encoding: .utf8)
//
//            print("\(html)")
//        }
        let jsonURL = "http://echo.jsontest.com/key/value/one/two"
        //   { "key" : "value", "one" : "two" }
//
        Alamofire.request(jsonURL).responseJSON { (response) in
            do {
                let json:JSONData? = try  JSONDecoder().decode(JSONData.self, from: response.data!)
                print(json?.one)
            }catch {
                print(error)
            }
        }
        print("do something.....")
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("vc1 viewDidLoad")
        
         NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityChanged(note:)), name: .reachabilityChanged, object: nil)
        
        var myQueue = DispatchQueue(label: "com.scentsome")
        myQueue = DispatchQueue.global()
        myQueue.async{
//            for i in 0...20 {
                print("heavy work 1")
//            }
        }
        print("hello")
        myQueue.async {
//            for i in 0...20 {
                print("heavy work 2")
//            }
        }
        
        var libraryURL = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=0a1e7957-7699-452c-8020-bf11a5408fc8"
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(libraryURL).responseJSON { (response) in
            if response.error != nil {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            do {
                var newLibrary:NewLibrary = try JSONDecoder().decode(NewLibrary.self, from: response.data!)
                
                self.libraries = newLibrary.result.results
                print(self.libraries)
                self.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }catch {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print(error)
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("vc1 viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("vc1 viewDidAppear")
        
        var userDefaults = UserDefaults.standard
        
        var password: String? = userDefaults.value(forKey: "password") as? String
        
        if password == nil {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
            
            present(loginVC!, animated: true, completion: nil)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("vc1 viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("vc1 viewDidDisappear")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if libraries == nil {
            return 0
        }
        return libraries!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellID = "CELL"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = libraries![indexPath.row].o_tlc_agency_name
        
        cell?.detailTextLabel?.text = libraries![indexPath.row].o_tlc_agency_address
        
        return cell!
    }
    
    
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var libraryTitle = libraries![indexPath.row].o_tlc_agency_name
        
        var infoVC:InfoViewController? = self.storyboard?.instantiateViewController(withIdentifier: "InfoVC") as? InfoViewController
         infoVC?.infoTitle = libraryTitle
        if infoVC != nil {
            present(infoVC!, animated: true, completion: {
//               infoVC?.titleLabel.text = libraryTitle

            })
        }
        
        
        
        
    }
    
    override  var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("size: \(size.width), \(size.height)")
        
        if size.width > size.height{
            print("landscape")
            
        } else if size.width < size.height{
            print("portrait")
            
        } else {
            print("Unknow")
        }
    }
    
    @IBAction func home(segue:UIStoryboardSegue) {
        
    }
}
extension ViewController : SelectViewControllerDelegate {
    func selectVC(_ select: SelectViewController, with date: Date) {
        
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY/MM/dd"
        
        self.dateLabel.text =  dateFormatter.string(from: date)
        print(date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var selectVC:SelectViewController? =  segue.destination as? SelectViewController
        
        selectVC?.delegate = self
    }
}
