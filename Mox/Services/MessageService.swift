//
//  MessageService.swift
//  Mox
//
//  Created by Earl Ledesma on 07/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]() // This is where we store our channels from Model Channel.swift
    var messages = [Message]()
    var selectedChannel : Channel? //Optional channels
    var unreadMessages = [String]()
    
    //Now we are ready to create our function (have our web request and hit our API, then bring back all of our channel)
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil { // Parse out the JSON
                guard let data = response.data else { return }
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel) // This is how to look through JSON objects and add it to our JSON array.
                        }
                        
//                        print(self.channels[0].channelTitle)
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                        completion(true) // after the channels are retrieved, we shoot this notification. Then we go to ChannelVC and observes that via NotificationCenter.default...
                    }
                } catch let error {
                    debugPrint(error as Any)
                    completion(false)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func updateUnreadMessages(withCurrentSelectedChannelId id: String) {
        if self.unreadMessages.count > 0 {
            self.unreadMessages = self.unreadMessages.filter({ (unreadId) -> Bool in
                return unreadId != id
            })
        }
    }
    
    
    func findAllMessages(forChannelId id: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            
                            self.messages.append(message)
                        }
                        print("Messages: \(self.messages)")
                        completion(true)
                    }
                } catch let error {
                    debugPrint(error as Any)
                    completion(false)
                }
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
}

