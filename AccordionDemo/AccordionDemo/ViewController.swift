//
//  ViewController.swift
//  AccordionDemo
//
//  Created by Michael on 12/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var crewList = ["1","2","3","1","2","3","1","2","3","1","2","3"]
    var customerList = ["a","b","c","a","b","c","a","b","c","a","b","c"]
    var shouldCloseSections = Set<Int>()
    override func viewDidLoad() {
        super.viewDidLoad()
//        shouldCloseSections.insert(7)
//        shouldCloseSections.insert(8)
//        shouldCloseSections.insert(9)
//        shouldCloseSections.insert(9)
//        shouldCloseSections.insert(9)
//        shouldCloseSections.insert(9)
//        print(shouldCloseSections)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return crewList.count
        }
        
        return customerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell")
        if indexPath.section == 0 {
            cell?.textLabel?.text = crewList[indexPath.row]

        }else {
            cell?.textLabel?.text = customerList[indexPath.row]
        }
        
        return cell!
    }
    
    
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Crew"
        }
        
        return "Customer"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var blueButton = UIButton()
        blueButton.backgroundColor = UIColor.blue
        blueButton.addTarget(self, action: #selector(ViewController.tapped(sender:)), for: UIControlEvents.touchUpInside)
        if section == 0 {
            blueButton.setTitle("Crew", for: .normal)
        }else {
            blueButton.setTitle("Customer", for: .normal)

        }
        blueButton.tag = section
        return blueButton
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if shouldCloseSections.contains(indexPath.section){
            return 0
        }
        return 44
    }
    
    @objc func tapped(sender:UIButton) {
        let tappedSection = sender.tag
        if shouldCloseSections.contains(tappedSection) {
            shouldCloseSections.remove(tappedSection)
        }else {
            shouldCloseSections.insert(tappedSection)
        }
        let indexSet = IndexSet(integer: tappedSection)
//        indexSet.insert(<#T##integer: IndexSet.Element##IndexSet.Element#>)
        tableView.reloadSections(indexSet, with: UITableViewRowAnimation.fade)
    }
}

