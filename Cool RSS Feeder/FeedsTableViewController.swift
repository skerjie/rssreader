//
//  FeedsTableViewController.swift
//  Cool RSS Feeder
//
//  Created by Andrei Palonski on 01.12.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class FeedsTableViewController: UITableViewController {
  
  var feeds = [Feed]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getFeeds()
  }
  
  func getFeeds() {
    do {
      feeds = try FeedDataHelper.findAll()!
      for feed in feeds {
        print(feed.getName())
      }
    } catch {
      print("Feed database access error")
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feeds.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsCell", for: indexPath) as! FeedsTableViewCell
    
    // fetch data
    
    let feed = feeds[indexPath.row]
    cell.nameLabel.text = feed.getName()
    cell.adressLabel.text = feed.getAdress()
    
    return cell
  }
  
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      
      let feed = feeds[indexPath.row]
      do {
        try FeedDataHelper.delete(item: feed)
      } catch _ {}
      
      feeds.remove(at: indexPath.row)
      
      tableView.deleteRows(at: [indexPath], with: .fade)
      
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }
}
