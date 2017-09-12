//
//  ShowingsCell.swift
//  ZooTv
//
//  Created by Peter Tao on 9/11/17.
//  Copyright © 2017 Peter Tao. All rights reserved.
//

import UIKit

class ShowingsTableViewCell: UITableViewCell {

    var showingTimeLabel: UILabel!
    var showingTitleLabel: UILabel!
    
    var showing: Showing? {
        didSet {
            if let s = showing {
                showingTitleLabel.text = s.title
                
                
                if s.startTime != nil {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "h:mm a"
                    let time = dateFormatter.string(from: s.startTime!)
                    showingTimeLabel.text = time
                }
                

                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        showingTimeLabel = UILabel()
        showingTimeLabel.font = UIFont(name: "Avenir", size: 18)
        contentView.addSubview(showingTimeLabel)
        
        showingTitleLabel = UILabel()
        showingTitleLabel.font = UIFont(name: "Avenir", size: 24)
        showingTitleLabel.adjustsFontSizeToFitWidth = true
        showingTitleLabel.numberOfLines = 0
        contentView.addSubview(showingTitleLabel)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = contentView.frame.width
        let h = contentView.frame.height
        
        
        
        showingTimeLabel.frame = CGRect(x: 12, y: 50, width: w - 24, height: 40)
        showingTitleLabel.frame = CGRect(x: 12, y: 12, width: self.contentView.frame.width - 24, height: 40)
        
    }

}
