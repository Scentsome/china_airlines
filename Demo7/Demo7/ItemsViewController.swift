//
//  ItemsViewController.swift
//  Demo7
//
//  Created by Michael on 29/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var isNew:Bool = false
//    var coverImage:String?
//    //    var coverImage:UIImage?
//    var coverText:String = ""
//    var timeLabel:String = ""
    var items:[DocItem] = ["a","b","c","a","b","c","a","b","c","a","b","c"].map { (str) -> DocItem in
        return DocItem(isNew:false, coverImage:nil, coverText:str, timeLabel:"\(Date())", pdfFilePath:"")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillLayoutSubviews() {
        if view.bounds.size.width > view.bounds.size.height {
            widthConstraint.constant = 620
        }else {
            widthConstraint.constant = 320
        }
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
extension ItemsViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.timeLabel.text = items[indexPath.row].timeLabel
        cell.coverTextView.text = items[indexPath.row].coverText
        
        return cell
    }
    
    
}


extension ItemsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedIndexPath = collectionView.indexPathsForSelectedItems![0]
//        let cell:ItemCell = collectionView.cellForItem(at: selectedIndexPath) as! ItemCell
        
        let item = items[selectedIndexPath.row]
        print(item)
        
        let pdfVC  = segue.destination as! PDFReaderViewController
        pdfVC.item = item
    }
}
