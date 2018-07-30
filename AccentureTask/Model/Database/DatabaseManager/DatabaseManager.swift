//
//  DatabaseManager.swift
//  AccentureTask
//
//  Created by Hasan on 4/22/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class DatabaseManager: NSObject {
  
  static let sharedInstance = DatabaseManager()
  
  let realm = try! Realm()
}


// MARK: Add
extension DatabaseManager {
  func addNewWeatherObject(dictionary: [String: Any]) -> WeatherObject {
    let json = JSON(dictionary)
    
    let object: WeatherObject = WeatherObject.init(dictionary: dictionary)
    
    if let list = json["list"].array {
      for data in list {
        let dataObj: WeatherData = WeatherData.init(json: data)
        dataObj.owner = object
        object.dataList.append(dataObj)
      }
    }
    
    updateRealmObject(object: object)
    
    return object
  }
}


// MARK: Get
extension DatabaseManager {
  func getAllWeather() -> Results<WeatherObject> {
    return realm.objects(WeatherObject.self)
  }
}


// MARK: CRUD
extension DatabaseManager {
  func clear() {
    try! realm.write {
      realm.deleteAll()
    }
  }
  
  func saveToRealm(object: Object) {
    try! realm.write {
      realm.add(object)
    }
  }
  
  func updateRealmObject(object: Object) {
    try! realm.write {
      realm.add(object, update: true)
    }
  }
  
  func deleteRealmObject(object: Object) {
    try! realm.write {
      realm.delete(object)
    }
  }
  
  func deleteRealmObjectList(objects: Results<Object>) {
    try! realm.write {
      realm.delete(objects)
    }
  }
  
}
