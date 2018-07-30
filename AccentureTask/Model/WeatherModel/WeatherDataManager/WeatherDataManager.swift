//
//  WeatherDataManager.swift
//  AccentureTask
//
//  Created by Hasan on 4/22/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation

class WeatherDataManager: NSObject {
  
  var collection = [WeatherObject]()
  
  // MARK: Lifecycle
  
  override init() {
    super.init()
    
    self.collection = DatabaseManager.sharedInstance.getAllWeather().toArray()
  }
  
  
  // MARK: Helper functions
  
  func getWeather(completion: @escaping (Bool) -> ()) {
    RequestManager.sharedInstance().requestWeather(nil, success: { (response) in
      let object = DatabaseManager.sharedInstance.addNewWeatherObject(dictionary: response as! ([String : Any]))
      self.collection.append(object)
      completion(true)
    }) { (error) in
      completion(false)
    }
  }
  
  // This functiom is when you need weather for a specific location
  func getWeatherByID(ID: String, completion: @escaping (Bool) -> ()) {
    RequestManager.sharedInstance().requestWeather(forID: ID, params: nil, success: { (response) in
      let object = DatabaseManager.sharedInstance.addNewWeatherObject(dictionary: response as! [String : Any])
      self.collection.append(object)
      completion(true)
    }) { (error) in
      completion(false)
    }
  }
  
  func deleteData(data: WeatherData, completion: () -> ()) {
    DatabaseManager.sharedInstance.deleteRealmObject(object: data)
    completion()
  }
  
  
  func count() -> Int {
    return self.collection.count
  }
  
}

