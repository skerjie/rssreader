//
//  WebViewController.swift
//  Cool RSS Feeder
//
//  Created by Andrei Palonski on 01.12.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

  var feedItem = FeedItems(title: "", description: "", link: "")
  
  func setFeedItem(feedItem: FeedItems) {
    self.feedItem = feedItem
  }
  
  @IBOutlet weak var webView: UIWebView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      UIWebView.loadRequest(webView) (URLRequest(url: URL(string: feedItem.getLink())!))

        // Do any additional setup after loading the view.
    }
}
