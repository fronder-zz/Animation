//
//  BaseViewController.swift
//  AccentureTask
//
//  Created by Hasan on 4/20/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  var completionBlock: (() -> Void)? = nil
  
  class func instantiate() -> UIViewController {return UIViewController()}
  
  // Storybord
  static func instantiate(viewControllerIdentifier: String) -> UIViewController {
    return instantiate(storyboardName: "Main", viewControllerIdentifier: viewControllerIdentifier)!
  }
  
  static func instantiate(storyboardName: String, viewControllerIdentifier: String) -> UIViewController? {
    return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerIdentifier)
  }
}
