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
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil) // This is observed after messageService notification is prompted, and channels are reloaded. Without this the channel will not populate after logging in.
        
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
        if AuthService.instance.isLoggedIn {
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
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
    
    @objc func userDataDidChange(_ notif: Notification) { // When we press log out, this will trigger userDataDidChange, it follows the else fun from setupUserInfo, this empties the array then reloads the chanel list.
        setupUserInfo()
        
    }
    
    @objc func channelsLoaded(_ notif:Notification) {
        tableView.reloadData() // just reloads data.
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
            tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row] // We create the channel based on what we selected
        MessageService.instance.selectedChannel = channel // set that into our selected channel ^^
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil) // Shoot notification that we have selected a channel
        
        self.revealViewController().revealToggle(animated: true) // we are access the VC and we call the toggle function to slide MENU back and forth. (e.g. everytime we click a channel, it toggles and moves to the chatVC, changes for every channel.)
    }
    
}
