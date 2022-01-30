//
//  DevCredRootView.Model.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

extension DevCredRootView {
  class Model {
    let config: DevCredConfig
    var dataSource: UITableViewDiffableDataSource<Section, Cell>?

    private var remoteDeveloper: DevCredDeveloperInfo?
    private var remoteProjects: [DevCredProjectInfo]?

    init(config: DevCredConfig) {
      self.config = config
    }

    private func updateDataSource() {
      let developer: DevCredDeveloperInfo?
      let projects: [DevCredProjectInfo]?

      switch config.infoSource {
      case .local(let localDeveloper, let localProjects):
        developer = localDeveloper
        projects = localProjects
      case .remote:
        developer = remoteDeveloper
        projects = remoteProjects
      }

      var snapshot = NSDiffableDataSourceSnapshot<Section, Cell>()

      if let developer = developer {
        snapshot.appendSections([.developer])
        snapshot.appendItems([
          .developer(developer)
        ], toSection: .developer)
      }

      if let projects = projects,
         !projects.isEmpty {
        snapshot.appendSections([.projects])
        snapshot.appendItems(projects.compactMap({ .project($0)} ), toSection: .projects)
      }

      dataSource?.apply(snapshot)
    }

    private func fetchRemoteInfo(from url: String, completion: @escaping () -> Void) {
      guard let url = URL(string: url) else {
        completion()
        return
      }

      let session = URLSession(configuration: .default)
      let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
        if let data = data,
           let remoteInfo = try? JSONDecoder().decode(DevCredRemoteInfo.self, from: data) {
          self?.remoteDeveloper = remoteInfo.developer
          self?.remoteProjects = remoteInfo.projects
        } else {
          print("Failed to load and/or decode remote info: \(error.debugDescription)")
        }

        completion()
      }
      dataTask.resume()
    }

    func setupData() {
      switch config.infoSource {
      case .local:
        updateDataSource()
      case .remote(let urlString):
        fetchRemoteInfo(from: urlString) {
          self.updateDataSource()
        }
      }
    }
  }
}
