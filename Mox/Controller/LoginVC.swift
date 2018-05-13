//
//  LoginVC.swift
//  Mox
//
//  Created by Earl Ledesma on 19/04/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var usertextName: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

        
    }

    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
       
        guard let email = usertextName.text , usertextName.text != "" else { return }
        guard let pass  = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccntBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil) //This connects "Don't have an account here?" into the Create Account VC //
        
    }
    
    func setUpView() {
        spinner.isHidden = true
        usertextName.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: moxPurplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: moxPurplePlaceHolder])
        
        
        
    }
}
