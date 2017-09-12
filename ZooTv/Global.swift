//
//  Global.swift
//  ZooTv
//
//  Created by Peter Tao on 9/10/17.
//  Copyright © 2017 Peter Tao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


// global singleton
struct Global {
    static var channels = [Channel]()
    static var startTime = Date()
    static func loadChannels(completion: @escaping () -> ()) {
        print("loading channels")
        Alamofire.request("https://damp-depths-69812.herokuapp.com/schedule").responseJSON { response in
            switch response.result {
            case .success(let value):
                channels.removeAll()
                let json = JSON(value)
                startTime = Date(timeIntervalSince1970: TimeInterval(exactly: json["startTime"].doubleValue/1000)!)
                
                
                print(startTime)
                for i in json["channels"] {
                    let newChannel = Channel(data: i.1)
                    channels.append(newChannel)
//                    print(i.1)
//                    print(i.1["showings"])

//                    if Post.validate(data: i.1) {
//                        let newAnnotation = BreadcrumbsAnnotation(post: Post(data: i.1))
//                        self.postAnnotations.append(newAnnotation)
//                        self.mapView.addAnnotation(newAnnotation)
//                    }
                }
            case .failure(let error):
                print(error)
            }
            
            completion()
        }
    }
    
    static func showBannerAlert(text: String, textColor: UIColor, backgroundColor: UIColor) {
        
    }
    
    private init() {}
}
