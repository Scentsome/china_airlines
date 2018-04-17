//
//  ViewController.swift
//  CrewCollectionDemo
//
//  Created by Michael on 17/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 50
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        var contentCell:ContentCollectionViewCell = (cell as? ContentCollectionViewCell)!
        
        if indexPath.section % 2 != 0 {
            contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            contentCell.backgroundColor = UIColor.yellow
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                contentCell.contentLabel.text = "Date"
            } else {
                contentCell.contentLabel.text = "Section"
            }
        } else {
            if indexPath.row == 0 {
                contentCell.contentLabel.text = String(indexPath.section)
            } else {
                contentCell.contentLabel.text = "Content"
            }
        }

        
        return contentCell
    }
    
    
}
