//
//  CircleImage.swift
//  Mox
//
//  Created by Earl Ledesma on 07/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit


@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
        
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2 // PERFECT CIRCLE, this turns the square background of avatar background shape in CreateAcountVC into a circle.
        self.clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
