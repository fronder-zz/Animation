//
//  WeatherObject.swift
//  AccentureTask
//
//  Created by Hasan on 4/22/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class WeatherObject: Object {
  @objc dynamic var id = "0"
  @objc dynamic var country = ""
  @objc dynamic var name = ""
  let dataList = List<WeatherData>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  convenience init(dictionary: [String: Any]) {
    self.init()
    let json = JSON(dictionary)
    if let city = json["city"].dictionary {
      if let value = city["id"]?.int {self.id = String(value)}
      if let value = city["country"]?.string {self.country = value}
      if let value = city["name"]?.string {self.name = value}
    }
  }
}
