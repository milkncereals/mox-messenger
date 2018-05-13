//
//  MessageCell.swift
//  Mox
//
//  Created by Earl Ledesma on 12/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    
    // Outlets
    
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        //2017-07-13T21:49:25.590Z  <-- This is the standard ISO 8691.
        
        // This is how to set the timestamp for the messages. (ie May 12-13, 9:43am)
        
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy:  -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
        }
        
    }

}
