//
//  Channel.swift
//  UmassTvGuide
//
//  Created by Ayodeji Marquis on 8/13/16.
//  Copyright © 2016 Ayodeji Marquis. All rights reserved.
//

import UIKit
import SwiftyJSON

class Channel {
    // MARK: Properties
    
    var name: String
    var number: String
    var image: UIImage?
    var showings = [Showing]()

    
    // MARK: Initialization
    
    init(data: JSON) {
        // Initialize stored properties.
        self.name = data["channelName"].stringValue
        self.image = UIImage(named: self.name) ?? UIImage(named: "unavailable")
        self.number = data["channelNumber"].stringValue
        initShowings(data: data["showings"])
    }
    
    func initShowings(data: JSON) {
        for showing in data {
            let newShowing = Showing(data: showing.1)
            showings.append(newShowing)
        }
    }
    
    
    
}
