//
//  AddChannelVC.swift
//  Mox
//
//  Created by Earl Ledesma on 07/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() // don't forget to call the function
        

    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text , nameTxt.text != "" else { return } // See SocketService.swift // unwrapping variables.
        guard let channelDesc = chanDesc.text else { return } // unwrapping variables..
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closeModalPressed(_ sender: Any) { //Touch Background to close popups
        dismiss(animated: true, completion: nil)//Touch Background to close popups
    }
    
    func setupView() {//Touch Background to close popups
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))//Touch Background to close popups
        bgView.addGestureRecognizer(closeTouch)//Touch Background to close popups
        
        //Placeholder font color
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor : moxPurplePlaceHolder])
        chanDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : moxPurplePlaceHolder])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}


// Channel Pop Up Method: Life Cycle: send emit to the API (name/desc info) will create a new channel object save that to the database and then emit of it's own to all apps that's connected
