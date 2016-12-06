//
//  FeedItemsTableViewController.swift
//  Cool RSS Feeder
//
//  Created by Andrei Palonski on 01.12.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class FeedItemsTableViewController: UITableViewController, XMLParserDelegate {
  
  var feedItems = [FeedItems]()
  var parser = XMLParser()
  var currentFeed:String!
  var entryTitle:String!
  var entryLink: String!
  var entryDescription: String!
  var curentParsedElement = String()
  var insideAnItem = false
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let dataStore = SQLiteDataStore.sharedInstance
    do {
      try dataStore.createTables()
      // checkDatabase()
    } catch _ {
      print("Error")
    }
    
    do {
      let feeds = try FeedDataHelper.findAll()
      for feed in feeds {
        currentFeed = feed.getAdress()
        let url: URL = URL(fileURLWithPath: feed.getAdress()!)
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
      }
      for feedItem in feedItems {
        print(feedItem.getTitle())
        print(feedItem.getDescription())
        print("---------")
      }
    } catch _ {
      print("Error getting feeds")
    }
  }
  
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    if elementName == "item" {
      insideAnItem = true
    }
    
    if insideAnItem {
      switch elementName {
      case "title": entryTitle = String()
      curentParsedElement = "title"
      case "description" : entryDescription = String()
      curentParsedElement = "description"
      case "link" : entryLink = String()
      curentParsedElement = "link"
      default: break
      }
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    if insideAnItem {
      switch curentParsedElement {
      case "title": entryTitle = entryTitle + string
      case "description": entryDescription = entryDescription + string
      case "link": entryLink = entryLink + string
      default: break
      }
    }
  }
  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if insideAnItem {
      switch elementName {
      case "title": curentParsedElement = ""
      case "description": curentParsedElement = ""
      case "link": curentParsedElement = ""
      default: break
      }
      if elementName == "item" {
        let feedItem = FeedItems(title: entryTitle, description: entryDescription, link: entryLink)
        feedItems.append(feedItem)
        insideAnItem = false
      }
    }
  }
  
  //  func checkDatabase() {
  //    do {
  //      let feed1 = try FeedDataHelper.insert(Feed(id: 0, name: "feed1", adress: "www.1")!)
  //      print(feed1)
  //      let feed2 = try FeedDataHelper.insert(Feed(id: 0, name: "feed2", adress: "www.2")!)
  //      print(feed2)
  //    } catch { }
  //
  //    do {
  //      if let feeds = try FeedDataHelper.findAll() {
  //        for feed in feeds {
  //          print("\(feed.id!) \(feed.name!) \(feed.adress!)")
  //         // try FeedDataHelper.delete(Feed)
  //        }
  //      }
  //    } catch _ {}
  //  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 0
  }
  
  /*
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
   
   // Configure the cell...
   
   return cell
   }
   */
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
