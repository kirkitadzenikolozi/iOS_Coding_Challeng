//
//  ViewController.swift
//  iOS_Coding_Challenge
//
//  Created by Nika Kirkitadze on 2/23/19.
//  Copyright © 2019 organization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var feedTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var results = [FeedModel.Feed.Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // very first title for navigationBar
        self.navigationItem.title = "Apple Music"
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        feedTableView.frame = view.frame
        view.addSubview(feedTableView)
        
        // register cell for identifier
        feedTableView.register(FeedResultCell.self, forCellReuseIdentifier: "FeedResultCell")
        feedTableView.estimatedRowHeight = 110
        
        // add right bar button
        let chooseMediaTypeButton = UIBarButtonItem(image: UIImage(named: "ic_filter"), style: .plain, target: self, action: #selector(chooseMediaType))
        self.navigationItem.rightBarButtonItem = chooseMediaTypeButton
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.results.removeAll()
        fetchAppleMusic()
    }
    
    @objc func chooseMediaType() {
        showActionSheet(vc: self)
    }
    
    func showActionSheet(vc: UIViewController) {
        var actionSheet: UIAlertController!
        
        // if iPad or iPhone
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        } else {
            actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        }
        
        actionSheet.addAction(UIAlertAction(title: "Apple Music", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            print("Apple Music")
            // first clear results array
            self.clearResults()
            self.setNavigationTitle(title: "Apple Music")
            self.fetchAppleMusic()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "iTunes Music", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            print("iTunes Music")
            // first clear results array
            self.clearResults()
            self.setNavigationTitle(title: "iTunes Music")
            self.fetchItunesMusic()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "iOS Apps", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            print("iOS Apps")
            // first clear results array
            self.clearResults()
            self.setNavigationTitle(title: "iOS Apps")
            self.fetchiOSApps()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Mac Apps", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            print("Mac Apps")
            // first clear results array
            self.clearResults()
            self.setNavigationTitle(title: "Mac Apps")
            self.fetchMacApps()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
}

// MARK - Functions
extension ViewController {
    
    func clearResults() {
        self.results.removeAll()
        self.feedTableView.reloadData()
    }
    
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func fetchAppleMusic() {
        APIService.shared.fetchFeed(method: .appleMusic, success: { (data) in
            guard let feed = data.feed else { return }
            
            if let results = feed.results {
                self.results = results
            }
            
            DispatchQueue.main.async {
                self.feedTableView.reloadData()
            }
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
    
    func fetchItunesMusic() {
        APIService.shared.fetchFeed(method: .itunesMusic, success: { (data) in
            guard let feed = data.feed else { return }
            
            if let results = feed.results {
                self.results = results
            }
            
            DispatchQueue.main.async {
                self.feedTableView.reloadData()
            }
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
    
    func fetchiOSApps() {
        APIService.shared.fetchFeed(method: .iosApps, success: { (data) in
            guard let feed = data.feed else { return }
            
            if let results = feed.results {
                self.results = results
            }
            
            DispatchQueue.main.async {
                self.feedTableView.reloadData()
            }
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
    
    func fetchMacApps() {
        APIService.shared.fetchFeed(method: .macApps, success: { (data) in
            guard let feed = data.feed else { return }
            
            if let results = feed.results {
                self.results = results
            }
            
            DispatchQueue.main.async {
                self.feedTableView.reloadData()
            }
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
}

// MARK - UITableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedResultCell") as! FeedResultCell
        
        let result = results[indexPath.row]

        cell.name = result.name!
        cell.artWorkURL = result.artworkUrl100!
        
        cell.layoutSubviews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let result = results[indexPath.row]
        if let urlString = result.url, let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
