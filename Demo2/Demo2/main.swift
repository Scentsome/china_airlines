//
//  main.swift
//  Demo2
//
//  Created by Michael on 17/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import Foundation

//var rect = Rectangle()
//rect.uuid = "123"
//var rect2 = Rectangle()
//rect2.uuid = "456"
//rect = rect2
var outArray:Array<Rectangle> = Array<Rectangle>()
for index in 0..<3 {
    var innerRect:Rectangle? = Rectangle()
    innerRect?.uuid = "id \(index)"
    outArray.append(innerRect!)
//    innerRect = nil
}

//
//class Super {
//    var sNum = 5
//    func superTest(){
//        print("super ",self.sNum)
//    }
//}
//
//class Sub : Super {
//    func testSub(){
//        super.superTest()
//        // print("super ",self.sNum)
//    }
//}
//var sub:Sub = Sub()
//sub.sNum = 88
//sub.testSub()
//
//
//
//print("Hello, World!")
//
//
//var play:Playground = Playground(num:2)
////play = Playground(num: 2)
////play.question = 45
//
//print(play.question)
//var r:Rectangle = Rectangle()
//
//r.set(x: 300, y: 400)
//r.center()
//r.set(x: 30, y: 40)
//r.center()
//
//
//var play3:Playground3 = Playground3(num:3)
//
//print(play3.question)
//
//var items:Array<Rectangle> = [Rectangle(),Rectangle(),Square()]
//
//var sum = 0
//for item:Rectangle in items {
//    sum = sum + item.area()
//}
//print(sum)
//
//var s:Square? = items[2] as? Square
//
//s?.area()



