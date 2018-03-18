//
//  Playground.swift
//  Demo2
//
//  Created by Michael on 17/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import Foundation

class Playground {
    var question:Int = 23
 
    func abGame() -> (Int, Int){
        // 
        return (1,0)
    }
    init(question:Int){
        self.question = question
    }
    init(num:Int){
        randomQuestion(num: num)
    }
    func randomQuestion(num:Int){
        var balls:[Int] = [Int](repeating: 9, count: 10)
        for index in 0..<balls.count {
            balls[index] = index
        }
        var questions = [Int](repeating: 10, count: num)
        for count:Int in 0..<num {
            let uValue = UInt32(count)
            let selectedIndex:UInt32 = arc4random_uniform(10 - uValue)
            let intIndex:Int = Int(selectedIndex)
            questions[count] = balls[intIndex]
            balls.remove(at: intIndex)
            print(questions)
        }
        var qValue = 0.0
        for (index,q) in questions.enumerated() {
            qValue += Double(q) * pow(Double(10), Double(questions.count -  index-1))
        }
        self.question = Int(qValue)

    }

}
