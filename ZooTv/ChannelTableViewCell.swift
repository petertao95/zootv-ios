//
//  SampleTableViewCell.swift
//  Sample1
//
//  Created by TheAppGuruz-New-6 on 04/02/15.
//  Copyright (c) 2015 TheAppGuruz-New-6. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {
    
    var channelNumberLabel: UILabel!
    var channelImageView: UIImageView!
    
    var channel: Channel? {
        didSet {
            if let c = channel {
                channelNumberLabel.text = c.number
                channelImageView.image = c.image

                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        channelNumberLabel = UILabel()
        contentView.addSubview(channelNumberLabel)

        channelImageView = UIImageView()
        channelImageView.contentMode = .scaleAspectFit
        contentView.addSubview(channelImageView)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
//        let w = contentView.frame.width
//        let h = contentView.frame.height
//      
        
        let imageLeading = NSLayoutConstraint(item: channelImageView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 12)
        let imageTop = NSLayoutConstraint(item: channelImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 12)
        let imageBottom = NSLayoutConstraint(item: channelImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -12)
        let imageAspectRatio = NSLayoutConstraint(item: channelImageView, attribute: .width, relatedBy: .equal, toItem: channelImageView, attribute: .height, multiplier: 1, constant: 0)
        channelImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([imageLeading, imageTop, imageBottom, imageAspectRatio])
        
        
//        let numberLeading = NSLayoutConstraint(item: channelNumberLabel, attribute: .leading, relatedBy: .equal, toItem: channelImageView, attribute: .trailing, multiplier: 1, constant: 20)
        let numberTrailing = NSLayoutConstraint(item: channelNumberLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20)
        let numberCenterY = NSLayoutConstraint(item: channelNumberLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        let numberHeight = NSLayoutConstraint(item: channelNumberLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: contentView.frame.height * 0.6)
        channelNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        channelNumberLabel.font = UIFont(name: "Avenir-Light", size: 55)
        channelNumberLabel.adjustsFontSizeToFitWidth = true
        self.addConstraints([numberTrailing, numberCenterY, numberHeight])
        
    }
    

}
