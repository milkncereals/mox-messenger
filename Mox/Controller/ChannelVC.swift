//
//  ChannelVC.swift
//  Mox
//
//  Created by Earl Ledesma on 28/02/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        /* This is to increase the visibility gap of ChatVC slider from ChannelVC slider.
        // The rearview should take up this much space <view,frame,size,width> except 60 points. */
    }


}
