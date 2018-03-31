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
    var document:PDFDocument = PDFDocument()
    var addAnnotations:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pdfPath = Bundle.main.path(forResource: "LearnToCode_1.1_introduction", ofType: "pdf") else {
            return
        }
        let pdfURL = URL(fileURLWithPath: pdfPath)
        document = PDFDocument(url: pdfURL)!
        document.unlock(withPassword: "1234")
        pdfView.document = document
//        document = pdfView.document!
        pdfView.autoScales = true
        pdfView.displaysPageBreaks = true

//        pdfView.displayMode = .singlePage
        print(pdfView.document?.outlineRoot)
        if(addAnnotations){
            addContractAnnotations()
        }

    }
    
    func addContractAnnotations() {
        
        let page:PDFPage = document.page(at: 0)!
        let pageBounds:CGRect = page.bounds(for: .cropBox)
        let checkBoxAgreeBounds:CGRect = CGRect(x: 75, y: pageBounds.size.height - 375, width: 18, height: 18)
        let checkBox:PDFAnnotation = PDFAnnotation(bounds: checkBoxAgreeBounds,forType: .widget,withProperties: nil)
        checkBox.widgetFieldType = .button
        checkBox.widgetControlType = .checkBoxControl
        page.addAnnotation(checkBox)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

