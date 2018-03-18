//
//  Circle.swift
//  Demo2
//
//  Created by Michael on 17/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import Foundation
class Circle : Shape {
    var radius = 300.0
    func area() -> Double {
        return Double.pi * radius
    }
}
