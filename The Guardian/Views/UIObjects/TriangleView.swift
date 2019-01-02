//
//  TriangleView.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 31/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

@IBDesignable final class TriangleView: UIView {
    
    private var path: UIBezierPath!
    
    override func draw(_ rect: CGRect) {
        createTriangle()
    }
    
    private func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.close()
        
        UIColor.white.setFill()
        path.fill()
    }
}
