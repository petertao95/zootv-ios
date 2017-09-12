//
//  SingleShowingViewController.swift
//  ZooTv
//
//  Created by Peter Tao on 9/12/17.
//  Copyright © 2017 Peter Tao. All rights reserved.
//

import UIKit

class SingleShowingViewController: UIViewController {

    var showing: Showing!
    var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTitle()
        
    }
    
    func setTitle() {
        let titleButton = UIButton()
        titleButton.setTitle(" \(showing.title ?? "showing")", for: .normal)
        titleButton.titleLabel?.font = UIFont(name: "Avenir", size: 18)
        
        titleButton.setTitleColor(UIColor.black, for: .normal)
        
        self.navigationItem.titleView = titleButton
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        
        let w = self.view.frame.width
        let h = self.view.frame.height
        let descriptionTextViewFrame = CGRect(x: 12, y: 12, width: w-24, height: h-24)
        
        descriptionTextView = UITextView(frame: descriptionTextViewFrame)
        descriptionTextView.attributedText = getTextViewText()
        descriptionTextView.isEditable = false
        self.view.addSubview(descriptionTextView)
    }
    
    func getTextViewText() -> NSMutableAttributedString {
        let text = getSubtitleText()
        text.append(getDescriptionText())
        text.append(getYearText())
        if text.string.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return NSMutableAttributedString(string: "No description", attributes: [ NSFontAttributeName: UIFont(name: "Avenir", size: 16.0)! ])
        } else {
            return text
        }
        
    }
    
    func getDescriptionText() -> NSMutableAttributedString {
        if let text = showing.description {
            let t = NSMutableAttributedString(string: "Description:\n", attributes: [ NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 16.0)! ])
            t.append(NSMutableAttributedString(string: text + "\n\n", attributes: [ NSFontAttributeName: UIFont(name: "Avenir", size: 16.0)! ]))
            return t
        } else {
            return NSMutableAttributedString(string: "")
        }
    }
    
    func getYearText() -> NSMutableAttributedString {
        if let text = showing.year {
            guard showing.year! != "" else { return NSMutableAttributedString(string: "")}
            let t = NSMutableAttributedString(string: "Year:\n", attributes: [ NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 16.0)! ])
            t.append(NSMutableAttributedString(string: text + "\n\n", attributes: [ NSFontAttributeName: UIFont(name: "Avenir", size: 16.0)! ]))
            return t
        } else {
            return NSMutableAttributedString(string: "")
        }
    }
    
    func getSubtitleText() -> NSMutableAttributedString {
        if let text = (showing.subtitle) {
            guard showing.subtitle! != "" else { return NSMutableAttributedString(string: "")}
            
            let t = NSMutableAttributedString(string: "Subtitle:\n", attributes: [ NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 16.0)! ])
            t.append(NSMutableAttributedString(string: text + "\n\n", attributes: [ NSFontAttributeName: UIFont(name: "Avenir", size: 16.0)! ]))
            return t
        } else {
            return NSMutableAttributedString(string: "")
        }
    }
    

}
