//
//  Library.swift
//  Demo5
//
//  Created by Michael on 22/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import Foundation
struct Library : Codable{
    var count:Int
    var books:[Book]
}

struct Book : Codable{
    var id:String
    var language:String
    var edition:String
    var author:String
//    var fileURL:String
}


