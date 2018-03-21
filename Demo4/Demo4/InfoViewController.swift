//
//  InfoViewController.swift
//  Demo4
//
//  Created by Michael on 21/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    var timer:Timer?
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func sayHello(_ sender: Any) {
        
        var urlString = "https://c1.staticflickr.com/3/2939/14415179182_f3e0a46f6c_b.jpg"
        let globalQueue = DispatchQueue.global()
        
        globalQueue.async {
            do  {
                
                let data = try Data(contentsOf: URL(string:urlString)!)
                let image = UIImage(data:data)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
                
            }catch {
                print("\(error)")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(InfoViewController.checkTime(sender:)), userInfo: nil, repeats: true)

        
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }

    @objc func checkTime(sender:Timer){
        print("timer")
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
    deinit {
        print("destroy")
    }
}
