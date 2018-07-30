//
//  ArrayExtension.swift
//  AccentureTask
//
//  Created by Hasan on 4/23/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
  
  func toArray() -> [WeatherObject] {
    var array = [WeatherObject]()
    for result in self {
      array.append(result as! WeatherObject)
    }
    return array
  }
  
}
