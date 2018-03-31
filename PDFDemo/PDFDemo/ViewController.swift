//
//  ViewController.swift
//  PDFDemo
//
//  Created by Michael on 31/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    var pdfFilePath = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pdfPath = Bundle.main.path(forResource: "china_airlines_2018_print5", ofType: "pdf") else {
            return
        }
        let pdfURL = URL(fileURLWithPath: pdfFilePath)
        pdfView.document = PDFDocument(url: pdfURL)
        
//        pdfView.scaleFactor = 1.0
        pdfView.displayMode = .singlePage
        print(pdfView.document?.outlineRoot)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

