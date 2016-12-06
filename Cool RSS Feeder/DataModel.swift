//
//  DataModel.swift
//  Cool RSS Feeder
//
//  Created by Andrei Palonski on 01.12.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import Foundation

// содержит ленты

class Feed {
  var id : Int64?
  var name : String?
  var adress : String?
  
  init? (id: Int64, name: String, adress: String) {
    self.id = id
    self.name = name
    self.adress = adress
    
    if name.isEmpty || adress.isEmpty {
      return nil
    }
  }
  
  func getId() -> Int64 {
    return id!
  }
  
  func getName() -> String {
    return name!
  }
  
  func getAdress() -> String {
    return adress!
  }
}

class FeedItems {
  
  var title : String
  var description : String
  var link : String
  
  init (title: String, description: String, link: String) {
    self.title = title
    self.description = description
    self.link = link
  }
  
  func getTitle() -> String {
    return title
  }
  
  func getDescription() -> String {
    return description
  }
  
  func getLink() -> String {
    return link
  }
  
}
