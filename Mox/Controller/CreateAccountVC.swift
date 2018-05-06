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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else { return // guard statements : unwrapping optional values, the values of the uI text field (optional string) therefore we need to unwrap them.
        }
        guard let pass = passTxt.text , passTxt.text != "" else { return //code read: pass text  where the passTxt.text does not equal an empty string, else we will return.
        }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in //CMD+ click ".registerUser" to check the path definition."
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        print("logged in user", AuthService.instance.authToken)
                        //Once we have have our email/pass we will call our register function inside the auth service. Server can sleep, so check out Hobby if you want a server that's always awake and responsive to any calls.
                        //print("registered user!") <-- this would be used instead of AuthService.instance.loginUser....
                    }
                })
            }
        }
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil) // This allows us to come back from Create Account VC to Channel VC via (X) Button Top Right.
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
