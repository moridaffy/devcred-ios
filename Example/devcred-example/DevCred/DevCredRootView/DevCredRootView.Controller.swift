//
//  DevCredRootView.Controller.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import Foundation
import UIKit

extension DevCredRootView {
  class Controller: UIViewController {
    private let tableView: UITableView = {
      let tableView = UITableView(frame: .zero, style: .grouped)
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.separatorStyle = .none
      tableView.backgroundColor = .clear

      tableView.register(DevCredDeveloperCell.self, forCellReuseIdentifier: String(describing: DevCredDeveloperCell.self))
      tableView.register(DevCredProjectCell.self, forCellReuseIdentifier: String(describing: DevCredProjectCell.self))

      return tableView
    }()

    private let viewModel: Model

    init(viewModel: Model) {
      self.viewModel = viewModel

      super.init(nibName: nil, bundle: nil)

      setupLayout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      setupBackground()
      setupTableView()

      viewModel.setupData()
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      setupNavigationBar()
    }

    private func setupLayout() {
      view.addSubview(tableView)

      view.addConstraints([
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
    }

    private func setupBackground() {
      switch viewModel.config.background {
      case .color(let color):
        view.backgroundColor = color ?? .systemBackground
      case .blur:
        // TODO
        break
      }
    }

    private func setupNavigationBar() {
      navigationController?.navigationBar.tintColor = viewModel.config.accentColor

      switch viewModel.config.presentationType {
      case.modal:
        if navigationItem.rightBarButtonItem == nil {
          navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .done,
            target: self,
            action: #selector(closeButtonTapped))
        }
      case .push:
        break
      }
    }

    private func setupTableView() {
      let dataSource = getDataSource(for: tableView)
      viewModel.dataSource = dataSource

      tableView.contentInset = view.safeAreaInsets
      tableView.dataSource = viewModel.dataSource
    }

    @objc private func closeButtonTapped() {
      dismiss(animated: true, completion: nil)
    }
  }
}
