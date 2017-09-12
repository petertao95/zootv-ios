//
//  Showing.swift
//  ZooTv
//
//  Created by Peter Tao on 9/11/17.
//  Copyright © 2017 Peter Tao. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Showing {
    var length: Int?    // the length in minutes
    var title: String?
    var year: String?
    var subtitle: String?
    var description: String?
    
    init(data: JSON) {
        self.length = data["length"].int
        self.title = data["title"].stringValue
        self.year = data["year"].string
        self.subtitle = data["subtitle"].string
        self.description = data["description"].string
    }
}
