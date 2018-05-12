//
//  ChatVC.swift
//  Mox
//
//  Created by Earl Ledesma on 28/02/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outletz (not an action)
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var channelNameLbl: UILabel!
    
    @IBOutlet weak var messageTxtBox: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 80 
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        revealViewController()
        
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
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func updateWithChannel() { // This updates the name of the channel via ChatVC (middle top). This is also not included above because we will be calling this function in other places.
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""; channelNameLbl.text = "#\(channelName)"  // ?? "" is essentially... coalesing nil, if it can't find a non-optional string, then set as an empty string
        getMessages()
    }

    @IBAction func sendMsgPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTxtBox.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion:  { (success) in
                if success {
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
                } else {
                    debugPrint("Error sending messsage")
                }
            })
        }
        
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in // returns an array of function...
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0] // This will set 1st
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channels yet..."
                }
            }
            // Do stuff with channels
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessages(forChannelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    
}

//MessageService.instance.findAllChannel { (success) in
//
//}
