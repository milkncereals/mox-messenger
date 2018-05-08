//
//  ChannelVC.swift
//  Mox
//
//  Created by Earl Ledesma on 28/02/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var loginButton: UIButton! // Need to change the title of the login button, we will display the user's name instead.
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){} //Not connect IBAction: This allows the segue unwind from Create Account VC back to ChannelVC (here);
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        /* This is to increase the visibility gap of ChatVC slider from ChannelVC slider.
        // The rearview should take up this much space <view,frame,size,width> except 60 points. */
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) { //This is so we can keep the login information of a person when they log out of the app.
        setupUserInfo()
    }
    
    
    @IBAction func addChannelPressed(_ sender: Any) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            //Show profile page
            let profile = ProfileVC() // instantiate
            profile.modalPresentationStyle = .custom // set modal presentation style
            present(profile, animated:  true, completion: nil) // present it.
            
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        setupUserInfo()
        
    }

    func setupUserInfo() {
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
    
    //WE need to conform otherwise delegate wont work from import
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
//            return ChannelCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
}
