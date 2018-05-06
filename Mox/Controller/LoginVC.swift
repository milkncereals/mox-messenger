//
//  LoginVC.swift
//  Mox
//
//  Created by Earl Ledesma on 19/04/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccntBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil) //This connects "Don't have an account here?" into the Create Account VC //
        
    }
}
