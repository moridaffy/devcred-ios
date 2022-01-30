//
//  DevCredRootView.DataSource.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

extension DevCredRootView {
  static func getDataSource(for tableView: UITableView) -> UITableViewDiffableDataSource<Section, Cell> {
    return UITableViewDiffableDataSource(tableView: tableView) { tableView, _, cellType in
      switch cellType {
      case .developer(let developerInfo):
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as? DevCredDeveloperCell else { return nil }
        cell.update(developer: developerInfo)
        return cell
      case .project(let projectInfo):
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as? DevCredProjectCell else { return nil }
        cell.update(project: projectInfo)
        return cell
      }
    }
  }
}

extension DevCredRootView {
  enum Section {
    case developer
    case projects
  }

  enum Cell: Hashable {
    case developer(DevCredDeveloperInfo)
    case project(DevCredProjectInfo)

    var reuseIdentifier: String {
      switch self {
      case .developer:
        return String(describing: DevCredDeveloperCell.self)
      case .project:
        return String(describing: DevCredProjectCell.self)
      }
    }
  }
}
