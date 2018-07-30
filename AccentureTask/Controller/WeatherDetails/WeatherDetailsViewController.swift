//
//  WeatherDetailsViewController.swift
//  AccentureTask
//
//  Created by Hasan on 4/24/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation

class WeatherDetailsViewController: BaseViewController {
  
  static let segueIdentifier = "WeatherDetailsViewControllerSegue"
  
  @IBOutlet weak var grndLevelDescriptionLabel: UILabel!
  @IBOutlet weak var humidityDescriptionLabel: UILabel!
  @IBOutlet weak var pressureDescriptionLabel: UILabel!
  @IBOutlet weak var seaLevelDescriptionLabel: UILabel!
  @IBOutlet weak var tempDescriptionLabel: UILabel!
  @IBOutlet weak var tempKfDescriptionLabel: UILabel!
  @IBOutlet weak var tempMaxDescriptionLabel: UILabel!
  @IBOutlet weak var tempMinDescriptionLabel: UILabel!
  
  var model: WeatherData?
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.grndLevelDescriptionLabel.text = String(describing: self.model!.grndLevel)
    self.humidityDescriptionLabel.text = String(describing: self.model!.humidity)
    self.pressureDescriptionLabel.text = String(describing: self.model!.pressure)
    self.seaLevelDescriptionLabel.text = String(describing: self.model!.seaLevel)
    self.tempDescriptionLabel.text = String(describing: self.model!.temp)
    self.tempKfDescriptionLabel.text = String(describing: self.model!.temp_kf)
    self.tempMaxDescriptionLabel.text = String(describing: self.model!.temp_max)
    self.tempMinDescriptionLabel.text = String(describing: self.model!.temp_min)
  }
  
  override class func instantiate() -> WeatherDetailsViewController {
    return WeatherDetailsViewController.instantiate(viewControllerIdentifier: String(describing: WeatherDetailsViewController.self)) as! WeatherDetailsViewController
  }
}
