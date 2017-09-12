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
    var searchText = ""

    
    // MARK: Initialization
    
    init(data: JSON) {
        // Initialize stored properties.
        self.name = data["channelName"].stringValue
        self.image = UIImage(named: self.name) ?? UIImage(named: "default")
        self.number = data["channelNumber"].stringValue
        initShowings(data: data["showings"])
        
        initSearchText()
    }
    
    func initShowings(data: JSON) {
        for showing in data {
            let newShowing = Showing(data: showing.1)
            showings.append(newShowing)
        }
    }
    
    func initSearchText() {
        searchText = "\(self.name)\(self.number)"
        for s in showings {
            let t = s.title ?? ""
            let d = s.description ?? ""
            let su = s.subtitle ?? ""
            let y = "\(s.year ?? "")"
            searchText.append("\(t)\(d)\(su)\(y)")
        }
        searchText = searchText.lowercased()
    }
    
    
    
}
