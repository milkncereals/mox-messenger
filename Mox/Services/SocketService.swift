//
//  SocketService.swift
//  Mox
//
//  Created by Earl Ledesma on 08/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit
import SocketIO // Socket.io documentation read:

//var manager = SocketManager(socketURL: BASE_URL)!, config: [.log(true), .compress])
var manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])

class SocketService: NSObject {
    
    static let instance = SocketService()  // This is a singleton just like all our other services
    override init() {
            super.init()  //We need to have an initializer because this is an NSObject
    }
    
//    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!) // unwrapping string
        var socket = manager.defaultSocket
    
    func establishConnection() {
        socket.connect() //connects to the server
    }
    
    func closeConnection(){
        socket.disconnect() // disconnect from the server
    }
    
    // WHen something is being sent via websocket = emit. Either the app or API, if the app -> server : (socket.emit). To receive information ... it's called (socket.on)
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
            socket.emit("newChannel", channelName, channelDescription)//Emit from our App to the API... newChannel/channelName/channelDescription's can be found from listeners in our API that's used.
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return } //Parse out the data array, channelName,desc, ID... to create a new channel object and append that to our messageservice channel array.
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
        // listening for an event...which is "channelCreated"
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
    }
    
    
    
   
}

}
