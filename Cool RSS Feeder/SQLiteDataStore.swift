//
//  SQLiteDataStore.swift
//  Cool RSS Feeder
//
//  Created by Andrei Palonski on 01.12.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import Foundation
import SQLite

enum DataAccessError: Error {
  case Datatore_Connection_Error
  case Insert_Error
  case Delete_Error
  case Search_Error
  case Nil_In_Data
}

class SQLiteDataStore {
  
  static let sharedInstance = SQLiteDataStore()
  
  let BBDB :Connection?
  
  private init() {
    
    var path = "db.sqlite"
    
    if let dirs : [NSString] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true) as [NSString] {
      let dir = dirs[0]
      path = dir.appendingPathComponent("db.sqlite") //.strings(byAppendingPaths: "db.sqlite" )
      print(path)
    }
    do {
      BBDB = try Connection (path)
    } catch _ {
      BBDB = nil
    }
  }
  
  func createTables () throws {
    do {
      try FeedDataHelper.createTable()
    } catch {
      throw DataAccessError.Datatore_Connection_Error
    }
  }
}


