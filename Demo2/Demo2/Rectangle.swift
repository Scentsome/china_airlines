//
//  Rectangle.swift
//  Demo2
//
//  Created by Michael on 17/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import Foundation
class Rectangle : Shape{
    var uuid:String = "test"
    var x:Float = 20.0
    var y:Float = 30.0
    var width:Float = 100.0
    var height:Float = 200.0
    
    func set(x:Float, y:Float)  {
        self.x = x
        self.y = y
    }
    func center() -> Void {
        let cx:Float = self.x + self.width / 2
        let cy:Float = self.y + self.height / 2
        
        print("Center",cx,cy)
    }
    
    func area() -> Double {
        
        
        return Double( width * height )
    }
    
    deinit {
        print(" destroy Rectangle ",self.uuid)
    }
}
