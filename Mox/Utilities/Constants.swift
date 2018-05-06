//
//  Constants.swift
//  Mox
//
//  Created by Earl Ledesma on 19/04/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()
// typealias is renaming a type, egg. typealias earl = string, then let name: earl = "earl". This is just remapping all of this into this type.
// (_ Success:Bool) -> () -->> Closure, a first class function that can be passed around in code. Once a web req is done, we'll say completed and pass into closure (true/false) and we can do a check if it's passed or not.

// URL Constants
let BASE_URL = "https://moxchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register" //\(base_url): This is string extrapolation
let URL_LOGIN = "\(BASE_URL)account/login" // these URLs are going to a specific location in the API, so that the API knows what to do with thhe information/request that it's receiving.

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"


// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers

let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
