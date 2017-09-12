//
//  ShowingsCell.swift
//  ZooTv
//
//  Created by Peter Tao on 9/11/17.
//  Copyright © 2017 Peter Tao. All rights reserved.
//

import UIKit

class ShowingsTableViewCell: UITableViewCell {

    var showingDescriptionLabel: UILabel!
    var showingTitleLabel: UILabel!
    
    var showing: Showing? {
        didSet {
            if let s = showing {
                showingTitleLabel.text = s.title
                showingDescriptionLabel.text = s.description

                
                
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        showingDescriptionLabel = UILabel()
        contentView.addSubview(showingDescriptionLabel)
        
        showingTitleLabel = UILabel()
        contentView.addSubview(showingTitleLabel)
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = contentView.frame.width
        let h = contentView.frame.height
        
        showingDescriptionLabel.frame = CGRect(x: 12, y: 50, width: w - 12, height: 40)
        showingTitleLabel.frame = CGRect(x: 12, y: 12, width: self.contentView.frame.width - 12, height: 40)
        
    }

}
