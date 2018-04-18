//
//  ViewController.swift
//  ResumeDataDownloadDemo
//
//  Created by Michael on 18/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import Cache
import Alamofire

class ViewController: UIViewController {

    var storage:Storage?
    var downloadRequest:DownloadRequest?
    
    @IBAction func testDownload(_ sender: Any) {
        beginDownload(urlString:"https://-----")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let diskConfig = DiskConfig(
            name: "Floppy",
            expiry: .date(Date().addingTimeInterval(2*3600)),
            maxSize: 10000,
            directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                    appropriateFor: nil, create: true).appendingPathComponent("MyPreferences"),
            protectionType: .complete
        )
        
        let memoryConfig = MemoryConfig(
            expiry: .date(Date().addingTimeInterval(2*60)),
            countLimit: 50,
            totalCostLimit: 0
        )
        do {
            storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginDownload(urlString:String) {
        do {
            let resumeData = try? storage?.object(ofType: Data.self, forKey: urlString)
            if resumeData != nil {
                self.startDownload(with: resumeData!,url:URL(string:urlString)!)
            }else {
                self.startDownload(url:URL(string:urlString)!)
            }
        }catch {
            print(error)
        }
    }
    func startDownload(with resumeData: Data? = nil, url:URL) {
        let destination: DownloadRequest.DownloadFileDestination = {temporaryURL, response in
            return (URL(fileURLWithPath:"/Users/michael/Desktop/tmp/tmp.zip"), [.removePreviousFile])
        }
        if let resumeData = resumeData {
            downloadRequest = Alamofire.download(resumingWith: resumeData, to: destination)
        } else {
            downloadRequest = Alamofire.download(url, to:destination)
        }
        downloadRequest?.downloadProgress { progress in
            print(progress.fractionCompleted)
            }.response { defaultDownloadResponse in
                if let error = defaultDownloadResponse.error {
                    print("Download Failed with error - \(error)")
                    if let resumeData = defaultDownloadResponse.resumeData {
                        do {
                            try self.storage?.setObject(resumeData, forKey: url.absoluteString)
                            print("write to cache",resumeData.count)
                            
                        }catch {
                            print(error)
                        }
                    }
                    return
                }
//                guard let downloadedFilePath = self.downloadedFilePath else { return }
//                print("Downloaded file successfully to \(downloadedFilePath)")
        }
        
        // download progress, next slide
    }


}

