//
//  main.swift
//  DownloadImage
//
//  Created by Michael on 17/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import Foundation

print("Hello, World!")
var imageURL = URL(string: "https://c1.staticflickr.com/3/2915/14603452681_5a7ac56d62_b.jpg")!


var config = URLSessionConfiguration.default

var session:URLSession = URLSession(configuration: config , delegate: FileHandler(), delegateQueue: nil)

var task:URLSessionDownloadTask = session.downloadTask(with: imageURL)
task.resume()
var runLoop = RunLoop.current;
runLoop.run()

