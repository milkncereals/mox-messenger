//
//  AuthService.swift
//  Mox
//
//  Created by Earl Ledesma on 06/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import Foundation
import Alamofire // Register user function, create web request specifiy headers/body and see the response come back. Alamofire is a library built ontop of apple's url session framework which makes web request easier.
import SwiftyJSON

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
    
    var addId: String {
        get {
            return defaults.value(forKey: ADD_ID) as! String
        }
        set {
            defaults.set(newValue, forKey: ADD_ID) //These variables wil be persisted as the app launches
        }
    }
    
    var addColor: String {
        get {
            return defaults.value(forKey: ADD_COLOR) as! String
        }
        set {
            defaults.set(newValue, forKey: ADD_COLOR) //These variables wil be persisted as the app launches
        }
    }
    
    var addAvatarName: String {
        get {
            return defaults.value(forKey: ADD_AVATAR_NAME) as! String
        }
        set {
            defaults.set(newValue, forKey: ADD_AVATAR_NAME) //These variables wil be persisted as the app launches
        }
    }
    
    var addEmail: String {
        get {
            return defaults.value(forKey: ADD_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: ADD_EMAIL) //These variables wil be persisted as the app launches
        }
    }
    
    var addName: String {
        get {
            return defaults.value(forKey: ADD_NAME) as! String
        }
        set {
            defaults.set(newValue, forKey: ADD_NAME) //These variables wil be persisted as the app launches
        }
    }
    
// cut here
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        //because web requests are asynchronous (we don't know when response go back), we need a way of knowing when it's finished. We do this via "completion handler"
        //Check Constants.swift for the completionhandler.
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true) //if everything goes fine, then it's true
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        //.responseString is used but you may exchange this to .responseJSON (because this would be used majority of the time).
    }    
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as?
                    Dictionary<String, Any> { //cast result.value as dictionary (type string), the key is always a string, but the value could be anything, bool, string , int etc... (therefore we choose anyh)
                    // The syntax for working with JSON dictionary, all we've to do is...
                    if let email = json["user"] as? String { // if we find the email we will cast it as a string, if successful then we'll self.userEmail = token.
                        self.userEmail = email
                    }
                    if let token = json["token"] as? String { // if we find the token key we will cast it as a string, if successful then we'll self.authToken = token.
                        self.authToken = token
                    }
                } // this casting is not good practice for handling JSON, hence why SWIFTYJSON is good to use.
                
//                //Using SwiftyJSON
//                guard let data = response.data else { return } // It creates a JSON object out of the ub resposne.data, so we need a data
//                let json = JSON(data: data)
//                self.userEmail = json["user"].stringValue //This automatically/safety unwraps the value for you, or it will set it into an empty string.
//                self.authToken = json["token"].stringValue //++ reasons why SwiftyJSON is a better. 4 lines vs 8 lines of code (compared above) no need to cast Dictionaries, no need for if/lets, no need to cast as Strings etc...
//
                
                self.isLoggedIn = true // If everything went fine, then thats it. Now we've successfully logged in a user.
                completion(true) //we need to know how to receive JSON from API "JSON Parsing"
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        //responseJSON is used now, because the response is specified in the API as JSON.
    }

    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        let header = [
            "Authorization":"Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil {
                if let json = response.result.value as?
                    Dictionary<String, Any> { //cast result.value as dictionary (type string), the key is always a string, but the value could be anything, bool, string , int etc... (therefore we choose anyh)
                    // The syntax for working with JSON dictionary, all we've to do is...
                    if let id = json["_id"] as? String {
                        self.addId = id
                    }
                    if let color = json["avatarColor"] as? String {
                        self.addColor = color
                    }
                    if let avatarName = json["avatarName"] as? String {
                        self.addAvatarName = avatarName
                    }
                    if let email = json["email"] as? String {
                        self.addEmail = email
                    }
                    if let name = json["name"] as? String {
                        self.addName = name
                        
                    }
                
//                //Using SwiftyJSON
//                guard let data = response.data else { return }
//                let json = JSON(data: data)
//                let id = json["_id"].stringValue
//                let color = json["avatarColor"].stringValue
//                let avatarName = json["avatarName"].stringValue
//                let email = json["email"].stringValue
//                let name = json["name"].stringValue
                    
                    UserDataService.instance
                    .setUserData(id: self.addId, color: self.addColor, avatarName: self.addAvatarName, email: self.addEmail, name: self.addName)
                    completion(true)
                    
                    
                    
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
                
                
            }
        }
    }

}



}
