//
//  GradientView.swift
//  Mox
//
//  Created by Earl Ledesma on 18/04/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

@IBDesignable /* This class know it needs to render inside of the story board */
class GradientView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.5803921569, green: 0.1294117647, blue: 0.5725490196, alpha: 1) { /* UI Color = Color Literal */
        didSet {
            self.setNeedsLayout() /*When making changes, this just sets the new change (dynamically) */
            
        }
    }

    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1) { /* UI Color = Color Literal */
        didSet {
            self.setNeedsLayout() /*When making changes, this just sets the new change from above */
            
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        /* CA = Core Animation */
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor] /* We can add additional color gradients here, we're not stuck with just 2 */
        
        /* cascade from top left to bottom right is (0,0) -> (1,1) coordinates */
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) /* CG = Core Graphics */
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) /* if you want horizontal x 0.5, y 0, then x 0.5, y 1 ... for vertical x 0, y0.5, x 1, y0.5 */
        gradientLayer.frame = self.bounds /* Size will be same as size of the UI view that's a subclass of e.g. bounds */
       self.layer.insertSublayer(gradientLayer, at: 0) /* we insert it to the UI View itself */
        
        
    }
}
