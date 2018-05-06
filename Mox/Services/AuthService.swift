//
//  AuthService.swift
//  Mox
//
//  Created by Earl Ledesma on 06/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import Foundation
import Alamofire // Register user function, create web request specifiy headers/body and see the response come back. Alamofire is a library built ontop of apple's url session framework which makes web request easier.

/*  https://github.com/Alamofire/Alamofire */


class AuthService {
    static let instance = AuthService() // This is a singleton meaning it can only exists once at any given time and is installed globally. This will handle the login create user and other variables required.
    
    let defaults = UserDefaults.standard // This is to save data in our app. Do not use for images/heavy duty data. (It's a simple method to use for small things such as strings, booleans etc..) (NOT SECURE, do not store passwords here.)
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY) //These variables wil be persisted as the app launches
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY) //These variables wil be persisted as the app launches
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL) //These variables wil be persisted as the app launches
        }
    }

    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        //because web requests are asynchronous (we don't know when response go back), we need a way of knowing when it's finished. We do this via "completion handler"
        //Check Constants.swift for the completionhandler.
        
        let lowerCaseEmail = email.lowercased()
        
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            if response.result.error == nil {
                completion(true) //if everything goes fine, then it's true
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        //.responseString is used but you may exchange this to .responseJSON (because this would be used majority of the time).
    }    
}
