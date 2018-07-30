//
//  WeatherData.swift
//  AccentureTask
//
//  Created by Hasan on 4/22/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class WeatherData: Object {
  
  @objc dynamic var temp: Float = 0
  @objc dynamic var temp_kf: Float = 0
  @objc dynamic var temp_max: Float = 0
  @objc dynamic var temp_min: Float = 0
  @objc dynamic var grndLevel: Float = 0
  @objc dynamic var humidity: Float = 0
  @objc dynamic var date: Int = 0
  @objc dynamic var pressure: Float = 0
  @objc dynamic var seaLevel: Float = 0
  
  @objc dynamic weak var owner: WeatherObject!
  
  convenience init(json: JSON) {
    self.init()
    if let main = json["main"].dictionary {
      if let value = main["temp"]?.float {self.temp = value}
      if let value = main["temp_kf"]?.float {self.temp_kf = value}
      if let value = main["temp_max"]?.float {self.temp_max = value}
      if let value = main["temp_min"]?.float {self.temp_min = value}
      if let value = main["grnd_level"]?.float {self.grndLevel = value}
      if let value = main["humidity"]?.float {self.humidity = value}
      if let value = main["pressure"]?.float {self.pressure = value}
      if let value = main["sea_level"]?.float {self.seaLevel = value}
    }
    if let value = json["dt"].int {self.date = value}
  }
}
