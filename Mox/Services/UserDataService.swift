//
//  UserDataService.swift
//  Mox
//
//  Created by Earl Ledesma on 06/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = "" // We're creating a public getter variable (other classes can read it) but other classes aren't allowed to set this variable directly. Only "var id" can directly modify the value of the ID that's set to.
    public private(set) var avatarColor = ""
    public private(set) var avatarName  = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) { // We need something to set these private varaibles.
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    } //Set all the variables we need to pass into this function
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    } //We'll need a function to update the avatar name.
    
}


