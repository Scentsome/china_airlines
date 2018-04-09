//
//  LeftViewController.swift
//  CustomizeSplitView
//
//  Created by Michael on 08/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    var dataList = ["a","b","c","d","e"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LeftViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftCell")
        cell?.textLabel?.text = dataList[indexPath.row]
        return cell!
    }
}
extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = dataList[indexPath.row]
        guard let rightVC = parent?.childViewControllers[1] as? RightViewController else {return}
        rightVC.updateLabel(byData: selectedData)
    }
}
