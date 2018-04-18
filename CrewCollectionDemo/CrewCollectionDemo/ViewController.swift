//
//  ViewController.swift
//  CrewCollectionDemo
//
//  Created by Michael on 17/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var upperConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lowerConstraint: NSLayoutConstraint!
    
    
    let columnTitles = ["RMK", "ChkIN", "empNO", "Name/EName",
        "Meal", "Sern", "Qual", "SpCode", "Rpt"]
    
    var datas:[Data] = []

    
    func loadFakeData() {
        
        let data1 = Data(rmk: "TVL", chkIN: "N", empNO: "12345678",
                         name: "TZU-HAN, LI/Cora Li", meal: "A",
                         sern: "12345678", qual: "1234", spCode: "1234", rpt: "CALPARK")
        
        for _ in 0...49 {
            datas.append(data1)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFakeData()
        
        print(collectionView.collectionViewLayout)
        let customLayout = collectionView.collectionViewLayout as? CustomCollectionViewLayout
        
//        CustomCollectionViewLayout()
        customLayout?.numberOfColumns = 9
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return UIInterfaceOrientationMask.all
        }
    }


}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnTitles.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        var contentCell:ContentCollectionViewCell = (cell as? ContentCollectionViewCell)!
        
        if indexPath.section % 2 != 0 {
            contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            contentCell.backgroundColor = UIColor.yellow
        }
        
        if indexPath.section == 0 {
//            if indexPath.row == 0 {
//                contentCell.contentLabel.text = "Date"
//            } else {
//                contentCell.contentLabel.text = "Section"
//            }
            contentCell.contentLabel.text = columnTitles[indexPath.row]

        } else {
//            if indexPath.row == 0 {
//                contentCell.contentLabel.text = String(indexPath.section)
//            } else {
//                contentCell.contentLabel.text = "Content"
//            }
            
            switch indexPath.row {
            case 0:
                contentCell.contentLabel.text = datas[indexPath.section].rmk
            case 1:
                contentCell.contentLabel.text = datas[indexPath.section].chkIN
            case 2:
                contentCell.contentLabel.text = datas[indexPath.section].empNO
            case 3:
                contentCell.contentLabel.text = datas[indexPath.section].name
                
            default:
                break
            }
        }

        
        return contentCell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.width > size.height {
            upperConstraint.constant = 0
            lowerConstraint.constant = 0
            

        }else {
            upperConstraint.constant = 120
            lowerConstraint.constant = 140
        }
    }
}
