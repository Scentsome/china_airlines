//
//  Data.swift
//  UICollectionViewWithStickyRowsAndColumns
//
//  Created by cora on 2018/4/10.
//  Copyright © 2018年 cora. All rights reserved.
//

import Foundation

class Data {
    
    let rmk:String
    let chkIN:String
    let empNO:String
    let name:String
    let meal:String
    let sern:String
    let qual:String
    let spCode:String
    let rpt:String
    
    init(rmk:String, chkIN:String, empNO:String, name:String, meal:String, sern:String, qual:String, spCode:String, rpt:String) {
        
        self.rmk = rmk
        self.chkIN = chkIN
        self.empNO = empNO
        self.name = name
        self.meal = meal
        self.sern = sern
        self.qual = qual
        self.spCode = spCode
        self.rpt = rpt
        
    }
}
