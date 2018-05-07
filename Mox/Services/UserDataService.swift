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
    
    func returnUIColor(components: String) -> UIColor {
//        "[0.5, 0.5, 0.5, 1]"
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ") // this is skipped.
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString? //?NSString = optional
        scanner.scanUpToCharacters(from: comma, into: &r) // &r = save to R up to the comma, then ignore the rest and repeat)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        
        // This will return our default incase things go wrong from above... we need to unwrap trhem.
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        //Strings will have to be convert to CGFloats... no direct conversion though... so we'll have to do String -> DoubleValue -> CGFloat
        
        
        let rfloat = CGFloat(rUnwrapped.doubleValue) // String -> Double Value
        let gfloat = CGFloat(gUnwrapped.doubleValue) // String -> Double Value
        let bfloat = CGFloat(bUnwrapped.doubleValue) // String -> Double Value
        let afloat = CGFloat(aUnwrapped.doubleValue) // String -> Double Value
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat) // Double Value --> CGFloats
        
        
        return newUIColor
    }
    
    
    
    
    
    
}


