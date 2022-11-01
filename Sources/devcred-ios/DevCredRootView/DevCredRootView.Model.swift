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

    private func fetchRemoteInfo(from url: String, fallback: DevCredRemoteInfo?, completion: @escaping (String?) -> Void) {
      func onReceiveInfo(_ info: DevCredRemoteInfo?) {
        guard let info = info else {
          completion(nil)
          return
        }

        remoteDeveloper = info.developer

        if let excludedBundleId = config.excludedBundleId {
          remoteProjects = info.projects?.filter { project in
            guard let bundleId = project.bundleId,
                  !bundleId.isEmpty else { return true }
            return bundleId != excludedBundleId
          }
        } else {
          remoteProjects = info.projects
        }

        completion(info.title)
      }

      guard let url = URL(string: url) else {
        onReceiveInfo(fallback)
        return
      }

      let session = URLSession(configuration: .default)
      let dataTask = session.dataTask(with: url) { data, response, error in
        if let data = data,
           let remoteInfo = try? JSONDecoder().decode(DevCredRemoteInfo.self, from: data) {
          onReceiveInfo(remoteInfo)
        } else {
          print("Failed to load and/or decode remote info: \(error.debugDescription)")
          onReceiveInfo(fallback)
        }
      }
      dataTask.resume()
    }

    func setupData(completion: @escaping (String?) -> Void) {
      switch config.infoSource {
      case let .local(title, _, _):
        updateDataSource()
        completion(title)
      case let .remote(urlString, fallback):
        fetchRemoteInfo(from: urlString, fallback: fallback) { title in
          DispatchQueue.main.async {
            completion(title)
            self.updateDataSource()
          }
        }
      }
    }
  }
}
