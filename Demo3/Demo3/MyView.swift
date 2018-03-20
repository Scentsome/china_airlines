//
//  MyView.swift
//  Demo3
//
//  Created by Michael on 20/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class MyView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var location = touches.first?.location(in: self)
        print("began",location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var location = touches.first?.location(in: self)
        print("moved",location)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ended")
    }

}
