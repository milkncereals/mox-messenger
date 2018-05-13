//
//  ChannelCell.swift
//  Mox
//
//  Created by Earl Ledesma on 07/05/2018.
//  Copyright © 2018 moxxvondee. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    
    //Outlet
    
    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0).cgColor // 1 is white's highest value
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        // Configure the view for the selected state
       
    }
    
    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? "" // if u can't return value, then just return empty string
        channelName.text = title
    }
}
