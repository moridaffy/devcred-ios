//
//  UITableView+Dequeue.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 31.01.2022.
//

import UIKit

extension UITableView {
  func registerCell(_ cellType: UITableViewCell.Type) {
    register(cellType.self, forCellReuseIdentifier: String(describing: cellType.self))
  }

  func dequeueCell<T: UITableViewCell>(_ cellType: T.Type) -> T? {
    dequeueReusableCell(withIdentifier: String(describing: cellType.self)) as? T
  }
}
