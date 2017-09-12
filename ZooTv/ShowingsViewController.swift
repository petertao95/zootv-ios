//
//  ShowingViewController.swift
//  ZooTv
//
//  Created by Peter Tao on 9/11/17.
//  Copyright © 2017 Peter Tao. All rights reserved.
//

import UIKit

class ShowingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var channel: Channel!
    var showingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        setTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let indexPath = showingsTableView.indexPathForSelectedRow {
            showingsTableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    func setTitle() {
        let titleButton = UIButton()
        titleButton.setTitle(channel.name + " (\(channel.number))", for: .normal)
        titleButton.titleLabel?.font = UIFont(name: "Avenir", size: 22)
//        titleButton.addTarget(self, action: #selector(self.scrollToTop), for: .touchUpInside)
        titleButton.setTitleColor(UIColor.black, for: .normal)
        
        self.navigationItem.titleView = titleButton
    }
    
    
//    func scrollToTop() {
//        self.showingsTableView.setContentOffset(CGPoint.zero, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channel.showings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ShowingsTableViewCell? = showingsTableView.dequeueReusableCell(withIdentifier: "showingsCell") as? ShowingsTableViewCell
        
        if(cell == nil) {
            cell = ShowingsTableViewCell(style: .default, reuseIdentifier: "channelCell");
        }
        cell!.showing = channel.showings[indexPath.row]
        return cell!
    }
    
    func addTableView() {
        showingsTableView = UITableView(frame: self.view.bounds)
        self.view.addSubview(showingsTableView)
        showingsTableView.rowHeight = 100
        showingsTableView.dataSource = self
        showingsTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = SingleShowingViewController()
        nextVC.showing = channel.showings[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}
