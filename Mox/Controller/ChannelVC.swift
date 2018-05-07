//
//  ChannelVC.swift
//  Mox
//
//  Created by Earl Ledesma on 28/02/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    // Outlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var loginButton: UIButton! // Need to change the title of the login button, we will display the user's name instead.
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){} //Not connect IBAction: This allows the segue unwind from Create Account VC back to ChannelVC (here);
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        /* This is to increase the visibility gap of ChatVC slider from ChannelVC slider.
        // The rearview should take up this much space <view,frame,size,width> except 60 points. */
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            
        } else {
            
            loginButton.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
        
    }

    
}
