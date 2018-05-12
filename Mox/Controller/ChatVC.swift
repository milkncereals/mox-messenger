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
    
    @IBOutlet weak var channelNameLbl: UILabel!
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) { // When we press log out, this will trigger userDataDidChange, it follows the else fun from setupUserInfo, this empties the array then reloads the chanel list.
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages() // getting channels
        } else {
            channelNameLbl.text = "Please Log In first"
        }
    }
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() { // This updates the name of the channel via ChatVC (middle top). This is also not included above because we will be calling this function in other places.
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""; channelNameLbl.text = "#\(channelName)"  // ?? "" is essentially... coalesing nil, if it can't find a non-optional string, then set as an empty string
    }

    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            // Do stuff with channels
        }
    }
}

//MessageService.instance.findAllChannel { (success) in
//
//}
