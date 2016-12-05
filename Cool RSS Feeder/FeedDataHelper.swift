//
//  FeedDataHelper.swift
//  Cool RSS Feeder
//
//  Created by Andrei Palonski on 01.12.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import Foundation
import SQLite

protocol DataHelperProtocol {
  associatedtype T
  static func createTable() throws -> Void
  static func insert(item: T) throws -> Int64
  static func delete(item: T) throws -> Void
  static func findAll() throws -> [T]?
}

class FeedDataHelper: DataHelperProtocol {
  static let TABLE_NAME = "Feeds"
  static let table = Table(TABLE_NAME)
  static let id = Expression<Int64> ("id")
  static let name = Expression<String> ("name")
  static let adress = Expression<String> ("adress")
  typealias T = Feed
  
  static func createTable() throws {
    guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
      throw DataAccessError.Datatore_Connection_Error
    }
    do {
      let _ = try DB.run(table.create(ifNotExists: true) { t in
        
        t.column(id, primaryKey: .autoincrement)
        t.column( name)
        t.column(adress)
      })
    } catch _ {
      
    }
  }
  
  static func insert(item: T) throws -> Int64 {
    guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
      throw DataAccessError.Datatore_Connection_Error
    }
    if (item.name != nil && item.adress != nil) {
      let insert = table.insert(name <- item.name!, adress <- item.adress!)
      do {
        let rowId = try DB.run(insert)
        guard rowId > 0 else {
          throw DataAccessError.Insert_Error
        }
        return rowId
      } catch _ {
        throw DataAccessError.Insert_Error
      }
    }
    throw DataAccessError.Nil_In_Data
  }
  
  static func delete(item: T) throws {
    guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
      throw DataAccessError.Datatore_Connection_Error
    }
    let query = table.filter(id == self.id)
    do {
      let tmp = try DB.run(query.delete())
      guard tmp == 1 else {
        throw DataAccessError.Delete_Error
      }
    } catch _{
      DataAccessError.Delete_Error
    }
  }
  
  static func find(id: Int64) throws -> T? {
    guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
      throw DataAccessError.Datatore_Connection_Error
    }
    let query = table.filter(self.id == id)
    let items = try DB.prepare(query)
    for item in items {
      return Feed(id: item[self.id], name: item[name], adress: item[adress])
    }
    return nil
  }
  
  static func findAll() throws -> [T]? {
    guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
      throw DataAccessError.Datatore_Connection_Error
    }
    var retArray = [T]()
    let items = try DB.prepare(table)
    for item in items {
      retArray.append(Feed(id: item[id], name: item[name], adress:item[adress])!)
    }
    return retArray
  }
  
}
