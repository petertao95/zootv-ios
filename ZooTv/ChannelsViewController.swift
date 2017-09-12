//
//  ViewController.swift
//  ZooTv
//
//  Created by Peter Tao on 9/10/17.
//  Copyright © 2017 Peter Tao. All rights reserved.
//

import UIKit
import Alamofire

class ChannelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var channelsTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        Global.loadChannels(completion: com)
        setTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let indexPath = channelsTableView.indexPathForSelectedRow {
            channelsTableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    
    func setTitle() {
        self.title = "ZooTV Guide"
        
    }
    
    func com() {
        print("reloading data")
        channelsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChannelTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "channelCell") as? ChannelTableViewCell
        if(cell == nil) {
            cell = ChannelTableViewCell(style: .default, reuseIdentifier: "channelCell");
        }
        cell!.channel = Global.channels[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ShowingsViewController()
        nextVC.channel = Global.channels[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setupTable() {
        channelsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        channelsTableView.rowHeight = 140
        self.view.addSubview(channelsTableView)
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
    }
    

}

