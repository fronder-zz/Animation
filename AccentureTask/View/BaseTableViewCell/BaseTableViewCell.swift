//
//  BaseTableViewCell.swift
//  AccentureTask
//
//  Created by Hasan on 4/23/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation

class BaseTableViewCell: UITableViewCell {
  
  class func cell(tableView: UITableView, indexPath: IndexPath) -> BaseTableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: String(describing: self), for: indexPath) as! BaseTableViewCell
  }
  
}
