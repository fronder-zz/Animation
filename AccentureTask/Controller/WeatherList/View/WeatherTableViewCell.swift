  //
//  WeatherTableViewCell.swift
//  AccentureTask
//
//  Created by Hasan on 4/23/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation

class WeatherTableViewCell: BaseTableViewCell {
  
  @IBOutlet private weak var temperatureLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  
  func setModel(model: WeatherData) {
    self.temperatureLabel.text = String(model.temp)
    self.dateLabel.text = NSDate(timeIntervalSince1970: TimeInterval(model.date)).description
  }
}
