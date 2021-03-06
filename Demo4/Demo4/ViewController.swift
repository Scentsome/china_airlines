//
//  ViewController.swift
//  Demo4
//
//  Created by Michael on 21/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var myData:[(title:String, isSelected:Bool)] = ["1","2","3","4","5","6","7","8","9","10","11","12","13"].map { (str) -> (String, Bool) in
        return (str,false)
    }
    // [("1",false),("2",false),("3",false)]
//    var newData:[(String,Bool)] = myData.map { (str) -> (String, Bool) in
//        return (str,false)
//    }
    
    @IBAction func addItem(_ sender: Any) {
        
        var defaults = UserDefaults.standard

        defaults.set(input.text!, forKey: "password")
        
        defaults.synchronize()
        
        
//        myData.append(input.text!)
        myData.insert((input.text!, false ), at: 0)
        
        tableView.reloadData()
    }
    
    @objc func sayHello(sender:UIButton){
        print("hi button")
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            if sender.state == UIControlState.highlighted {
                print("button...")
            }else {
                timer.invalidate()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        testBtn.addTarget(self, action: #selector(ViewController.sayHello(sender:)), for: UIControlEvents.touchDown)
        
        
    NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: nil) { (notification) in
            print(notification)
        }
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        print("documents", docFolder())
        print("home",NSHomeDirectory())
        
        
        var defaults = UserDefaults.standard
        
        var password:String? = defaults.string(forKey: "password")
        
        if password == nil  {
            print("No login")
            self.defaultLabel.text = "no password"
        }else {
            self.defaultLabel.text = password!
        }
        
        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func docFolder() -> String {
        var path: Array = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        var documentsDirectory: String = path[0]
        return documentsDirectory
    }

}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "DataCell"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        var myCell:MyTableViewCell? = cell as? MyTableViewCell
        
        myCell?.leftLabel.text = myData[indexPath.row].0
        
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
//            print("create cell")
//        }
//        cell?.textLabel?.text = myData[indexPath.row].0
//
//        if myData[indexPath.row].1 {
//            cell?.accessoryType = .checkmark
//        }else {
//            cell?.accessoryType = .none
//        }
        
        return myCell!
    }
    
    
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(myData[indexPath.row])
        
//        let cell:UITableViewCell? =  tableView.cellForRow(at: indexPath)
//        cell?.accessoryType = .checkmark
//        
//        myData[indexPath.row].1 = true
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        if indexPath.row % 2 == 0 {
//            return nil
//        }
//        return indexPath
//    }
}

