//
//  ShowingViewController.swift
//  ZooTv
//
//  Created by Peter Tao on 9/11/17.
//  Copyright © 2017 Peter Tao. All rights reserved.
//

import UIKit

class ShowingsViewController: UIViewController, UITableViewDataSource {

    var channel: Channel!
    var showingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        self.title = channel.name + " (\(channel.number))"
        print(channel.showings)
    }
    
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
    }

}
