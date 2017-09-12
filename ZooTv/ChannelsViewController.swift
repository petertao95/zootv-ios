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
    var leftItem: UIBarButtonItem!
    var timeLabel: UILabel!
    var filteredChannels = [Channel]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setTitle()
        setupSearchBar()
        addLeftBarButtonItem()
        
        loadChannels()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let indexPath = channelsTableView.indexPathForSelectedRow {
            channelsTableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        channelsTableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Shows, channels, descriptions"
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadChannels()
    }
    
    func addLeftBarButtonItem() {
        timeLabel = UILabel()
        timeLabel.text = "Loading..."
        timeLabel.font = UIFont(name: "Avenir-Light", size: 16)
        timeLabel.textColor = UIColor.lightGray
        timeLabel.sizeToFit()

        leftItem = UIBarButtonItem(customView: timeLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func loadChannels() {
        UIView.animate(withDuration: 0.3) {
            self.timeLabel.text = "Loading..."
            self.timeLabel.textColor = UIColor.lightGray
            self.timeLabel.sizeToFit()
        }
        
        Global.loadChannels(completion: reloadView)
    }
    
    
    func setTitle() {
        var titleButton = UIButton()
        titleButton.setTitle("ZooTV", for: .normal)
        titleButton.titleLabel?.font = UIFont(name: "Avenir", size: 22)
        titleButton.addTarget(self, action: #selector(self.scrollToTop), for: .touchUpInside)
        titleButton.setTitleColor(UIColor.black, for: .normal)
        
        self.navigationItem.titleView = titleButton
    }
    
    func scrollToTop() {
        self.channelsTableView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func reloadView() {
        refreshControl.endRefreshing()
        print("reloading data")
        UIView.animate(withDuration: 0.3) { 
            self.timeLabel.textColor = UIColor.black
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let date = dateFormatter.string(from: Global.startTime)
            
            self.timeLabel.text = date
            self.timeLabel.sizeToFit()
        }
        channelsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredChannels.count
        } else {
            return Global.channels.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChannelTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "channelCell") as? ChannelTableViewCell
        if(cell == nil) {
            cell = ChannelTableViewCell(style: .default, reuseIdentifier: "channelCell");
        }
        let currChannel: Channel!
        
        if isFiltering() {
            currChannel = filteredChannels[indexPath.row]
        } else {
            currChannel = Global.channels[indexPath.row]
        }
        
        cell!.channel = currChannel
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ShowingsViewController()
        
        if isFiltering() {
            nextVC.channel = filteredChannels[indexPath.row]
        } else {
            nextVC.channel = Global.channels[indexPath.row]
        }
        
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setupTable() {
        channelsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        channelsTableView.rowHeight = self.view.frame.height/6
        self.view.addSubview(channelsTableView)
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
        self.channelsTableView.insertSubview(refreshControl, at: 0)
    }
    
    // MARK: - Private instance methods
    
    func filterContentForSearchText(_ searchText: String) {
        filteredChannels = Global.channels.filter({( channel : Channel) -> Bool in
            
            if searchBarIsEmpty() {
                return true
            } else {
                return channel.searchText.contains(searchText.lowercased())
            }
        })
        channelsTableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive
    }
    

}

extension ChannelsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
