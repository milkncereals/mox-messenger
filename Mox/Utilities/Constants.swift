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
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)/channel"
let URL_GET_MESSAGES = "\(BASE_URL)/message/byChannel"



// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"



//Colors
let moxPurplePlaceHolder = #colorLiteral(red: 0.423529923, green: 0.6870478392, blue: 0.8348321319, alpha: 0.5)



//Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("notifChannelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("notifChannelSelected")

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
//let ADD_ID = "addId"
//let ADD_COLOR = "addColor"
//let ADD_AVATAR_NAME = "addAvatarName"
//let ADD_EMAIL = "addEmail"
//let ADD_NAME = "addName"

// Headers

let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
