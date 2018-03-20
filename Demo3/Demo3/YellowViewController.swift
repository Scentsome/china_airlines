//
//  YellowViewController.swift
//  Demo3
//
//  Created by Michael on 20/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func loadImage(_ sender: Any) {
        
        
        let imageFilePath = "/Users/michael/Desktop/port80.png"
        let fileURL = URL(fileURLWithPath: imageFilePath)
        
        do {
            let imageData = try Data(contentsOf: fileURL)
            
            let image = UIImage(data: imageData)
            
            self.imageView.image = image
            
        } catch {
            print(error)
        }
        
        
        
        
    }
    @IBAction func moveWhite(_ sender: Any) {
        
        
        


//        }
        
        
        UIView.animate(withDuration: 1.0, animations: {
            self.whiteView.center = CGPoint(x:100,y:100)
        }) { (_) in
            UIView.animate(withDuration: 1.0) {
                self.whiteView.frame = CGRect(x:20,y:80,width:20,height:30)
            }
        }
    }
    @IBAction func removeView(_ sender: Any) {
        let blueView:UIView? = self.view.viewWithTag(34)
//        blueView?.removeFromSuperview()
      blueView?.isHidden = true
    }
    @IBOutlet weak var whiteView: UIView!
    @IBAction func addView(_ sender: Any) {
        let blueView = UIView()
        blueView.tag = 34
        blueView.frame = CGRect(x: 20, y: 100, width: 120, height: 30)
        blueView.backgroundColor = UIColor.blue
//        whiteView.addSubview(blueView)
        self.view.addSubview(blueView)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.whiteView.layer.borderWidth = 5.0
        self.whiteView.layer.borderColor = UIColor.blue.cgColor
        self.whiteView.layer.cornerRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        print("began","Yellow Controller")
    }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            print("moved"," Yellow controller")
        }

   

}
