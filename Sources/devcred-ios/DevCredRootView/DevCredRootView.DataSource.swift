//
//  DevCredRootView.DataSource.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

extension DevCredRootView {
  static func getDataSource(for tableView: UITableView, viewModel: Model) -> UITableViewDiffableDataSource<Section, Cell> {
    return UITableViewDiffableDataSource(tableView: tableView) { tableView, _, itemIdentifier in
      switch itemIdentifier {
      case .developer(let developerInfo):
        guard let cell = tableView.dequeueCell(DevCredDeveloperCell.self) else { return nil }
        cell.update(developer: developerInfo, textColor: viewModel.config.textColor)
        return cell

      case .links(let links):
        guard let cell = tableView.dequeueCell(DevCredLinksCell.self) else { return nil }
        cell.update(links: links)
        return cell

      case .project(let projectInfo):
        guard let cell = tableView.dequeueCell(DevCredProjectCell.self) else { return nil }
        cell.update(project: projectInfo, accentColor: viewModel.config.accentColor, textColor: viewModel.config.textColor)
        return cell
      }
    }
  }
}

extension DevCredRootView {
  enum Section: Int {
    case developer
    case links
    case projects
  }

  enum Cell: Hashable {
    case developer(DevCredDeveloperInfo)
    case links([DevCredDeveloperInfo.SocialLink])
    case project(DevCredProjectInfo)
  }
}
