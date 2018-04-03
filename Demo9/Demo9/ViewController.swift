//
//  ViewController.swift
//  Demo9
//
//  Created by Michael on 03/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func handleRotation(_ sender: UIRotationGestureRecognizer) {
        
//        sender.rotation
        self.slider.transform = CGAffineTransform(rotationAngle: sender.rotation)
    }
    
    
    
    @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
        
        self.slider.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale);
    }
    
    @IBAction func tapHanlder(_ sender: UITapGestureRecognizer) {
        
        print("tap in", sender.location(in: self.view))
        print(self.view.bounds)
        print(UIScreen.main.bounds)
        
        switch sender.state {
            case .began:
                print("began")
            
            case .changed:
                print("changed")
            
            case .ended:
                print("ended")
            default:
                print("unknown")
        }
    }
    
    @IBAction func handleLongPress(sender:UILongPressGestureRecognizer){
        switch sender.state {
        case .began :
            print("began long press")
        case .changed :
            print("changeed long press")
        case .ended :
            print("ended long press")
        default:
            print("ignore..")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var rect = Rectangle()
        rect.setX(40, withY: 50)
        rect.width = 300
        rect.height = 600
        //        rect.price
        rect.center()
        
        rect.makeCircle()
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(ViewController.action(a:second:)), userInfo: nil, repeats: false)
        download()
        
    }
    
    func download(){
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        let manager:AFURLSessionManager = AFURLSessionManager(sessionConfiguration: configuration)
        
        let url:URL = URL(string: "https://i.pinimg.com/564x/08/57/0d/08570daccbdc9c8d5f9027a84be82b0b.jpg")!
        let request:NSURLRequest = NSURLRequest(url: url)
        
        let downloadTask:URLSessionDownloadTask = manager.downloadTask(with: request as URLRequest,progress: nil, destination: { (targetPath, response) -> URL in
                                                                        
            var documentsDirectoryURL:URL? = nil
            do {
                documentsDirectoryURL = try FileManager.default.url(for: .documentDirectory,in: .userDomainMask, appropriateFor: nil, create: false)
            } catch {
                print("Error")
            }
                                                                        
            return documentsDirectoryURL!.appendingPathComponent(response.suggestedFilename!)
                                                                        
        }) { (response, filePath, error) in
            print("File downloaded to: \(String(describing: filePath))")
        }
        
        downloadTask.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func action(a:Timer, second b:Int ) {
        print("action1")
    }
    @objc func action(action a:Timer, second b:Int){
        print("action2")
    }
    
    
}

