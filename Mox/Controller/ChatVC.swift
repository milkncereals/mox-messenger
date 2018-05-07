//
//  ChatVC.swift
//  Mox
//
//  Created by Earl Ledesma on 28/02/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // Outletz (not an action)
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        /* Target is going to be the revealViewController
        Selection is the method that's inside the SWReveal files
        UI ControlEvents is the UBOutlet drag feature.
        
        Target is self.revealViewController
         Selector is SWRevealViewController.revealToggle(_:)) - method we're invoking, the method is coming from the SWReveal file,
         UIControl events */
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) // This is the slide-feature to close
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer()) // This is the tap-gesture to close
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }

}
