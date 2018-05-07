//
//  CreateAccountVC.swift
//  Mox
//
//  Created by Earl Ledesma on 06/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Variables (Default)
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]" // Default light grey color RGB Alpha properties of a color (array)
    var bgColor: UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) { // This allows the change of Profile Default image to the one chosen from our avatarPicker.
        if UserDataService.instance.avatarName != "" { //is not still equal to that empty screen, then we have selected one from the picker.
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil { // This is to put a light gray background color if no background color + light avatar icon was chosen.
                userImg.backgroundColor = UIColor.lightGray
            }
        }
        
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
        
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let name = usernameTxt.text , usernameTxt.text != "" else { return // guard statements : unwrapping optional values, the values of the uI text field (optional string) therefore we need to unwrap them.
        }
        guard let email = emailTxt.text , emailTxt.text != "" else { return // guard statements : unwrapping optional values, the values of the uI text field (optional string) therefore we need to unwrap them.
        }
        guard let pass = passTxt.text , passTxt.text != "" else { return //code read: pass text  where the passTxt.text does not equal an empty string, else we will return.
        }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in //CMD+ click ".registerUser" to check the path definition." //AFTER I CLICK THE Create Account Button...WE REGISTER THE USER {1}
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in //AFTER I CLICK THE Create Account Button...WE REGISTER THE USER THEN WE LOGIN THE USER... {2}
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in //AFTER I CLICK THE Create Account Button...WE REGISTER THE USER, LOGIN THE USER THEN WE CREATE THE USER... {3}
                            if success {
                                self.spinner.isHidden = true // If success, spinner animation is hidden then closes.
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                    //print(UserDataService.instance.name, UserDataService.instance.avatarName)
                            }
                        })
//                        print("logged in user", AuthService.instance.authToken)
//                        //Once we have have our email/pass we will call our register function inside the auth service. Server can sleep, so check out Hobby if you want a server that's always awake and responsive to any calls.
//                        //print("registered user!") <-- this would be used instead of AuthService.instance.loginUser....
                    }
                })
            }
        }
    }
    // This is to change the color of the avatar's background on create acc VC
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255 //red,green,blue,alpha.. this is to genrate RGB value. randomly generated number of RGB values (upperbound). These colors are from between 1-255, divided by 255 to normalize the numbers.
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1) // alpha is 1 so it's NOT transparent at all
        UIView.animate(withDuration: 0.2) { // sets the animation of background color appearance. (Fade animation)
            self.userImg.backgroundColor = self.bgColor

        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil) // This allows us to come back from Create Account VC to Channel VC via (X) Button Top Right.
        
        
    }
    
    func setupView() {
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: moxPurplePlaceHolder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: moxPurplePlaceHolder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: moxPurplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap) //This will close the keyboard when tapped.
        
    }
    
    @objc func handleTap() { // This is a function that's exposed to objective-C
        view.endEditing(true) //if we have a keyboard open, tap then it'll close.
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
