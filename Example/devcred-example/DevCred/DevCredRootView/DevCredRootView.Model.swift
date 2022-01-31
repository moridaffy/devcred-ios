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

    var developer: DevCredDeveloperInfo? {
      switch config.infoSource {
      case .local(_, let developer, _):
        return developer
      case .remote:
        return remoteDeveloper
      }
    }
    var projects: [DevCredProjectInfo]? {
      switch config.infoSource {
      case .local(_, _, let projects):
        return projects
      case .remote:
        return remoteProjects
      }
    }

    init(config: DevCredConfig) {
      self.config = config
    }

    private func updateDataSource() {
      var snapshot = NSDiffableDataSourceSnapshot<Section, Cell>()

      if let developer = developer {
        snapshot.appendSections([.developer])
        snapshot.appendItems([
          .developer(developer)
        ], toSection: .developer)

        if let links = developer.links,
           !links.isEmpty {
          snapshot.appendSections([.links])
          snapshot.appendItems([.links(links)], toSection: .links)
        }
      }

      if let projects = projects,
         !projects.isEmpty {
        snapshot.appendSections([.projects])
        snapshot.appendItems(projects.compactMap({ .project($0)} ), toSection: .projects)
      }

      dataSource?.apply(snapshot)
    }

    private func fetchRemoteInfo(from url: String, completion: @escaping (String?) -> Void) {
      guard let url = URL(string: url) else {
        completion(nil)
        return
      }

      let session = URLSession(configuration: .default)
      let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
        if let data = data,
           let remoteInfo = try? JSONDecoder().decode(DevCredRemoteInfo.self, from: data) {
          self?.remoteDeveloper = remoteInfo.developer
          self?.remoteProjects = remoteInfo.projects

          completion(remoteInfo.title)
        } else {
          print("Failed to load and/or decode remote info: \(error.debugDescription)")
          completion(nil)
        }
      }
      dataTask.resume()
    }

    func setupData(completion: @escaping (String?) -> Void) {
      switch config.infoSource {
      case .local(let title, _, _):
        updateDataSource()
        completion(title)
      case .remote(let urlString):
        fetchRemoteInfo(from: urlString) { title in
          DispatchQueue.main.async {
            completion(title)
            self.updateDataSource()
          }
        }
      }
    }
  }
}
