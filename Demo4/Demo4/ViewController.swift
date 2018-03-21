//
//  ViewController.swift
//  Demo4
//
//  Created by Michael on 21/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
        
//        myData.append(input.text!)
        myData.insert((input.text!, false ), at: 0)
        
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

