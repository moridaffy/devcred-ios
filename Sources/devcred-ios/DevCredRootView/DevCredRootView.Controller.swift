//
//  DevCredRootView.Controller.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import Foundation
import UIKit

extension DevCredRootView {
  public class Controller: UIViewController {
    private let tableView: UITableView = {
      let tableView = UITableView(frame: .zero, style: .grouped)
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.separatorStyle = .none
      tableView.backgroundColor = .clear

      tableView.registerCell(DevCredDeveloperCell.self)
      tableView.registerCell(DevCredLinksCell.self)
      tableView.registerCell(DevCredProjectCell.self)

      return tableView
    }()

    private let viewModel: Model

    init(viewModel: Model) {
      self.viewModel = viewModel

      super.init(nibName: nil, bundle: nil)

      view.backgroundColor = .clear

      setupLayout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
      super.viewDidLoad()

      setupBackground()
      setupTableView()

      viewModel.setupData { [weak self] title in
        self?.title = title
      }
    }

    public override func viewWillAppear(_ animated: Bool) {
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
        tableView.backgroundColor = color ?? .systemBackground
      case .blurLight:
        tableView.backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
      case .blurDark:
        tableView.backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
      }
    }

    private func setupNavigationBar() {
      navigationController?.navigationBar.tintColor = viewModel.config.accentColor
      navigationController?.navigationBar.titleTextAttributes = [
        .foregroundColor: viewModel.config.textColor
      ]

      switch viewModel.config.background {
      case .blurLight:
        navigationController?.overrideUserInterfaceStyle = .light
      case .blurDark:
        navigationController?.overrideUserInterfaceStyle = .dark
      default:
        break
      }

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
      let dataSource = getDataSource(for: tableView, viewModel: viewModel)
      viewModel.dataSource = dataSource

      tableView.tintColor = viewModel.config.accentColor
      tableView.contentInset = view.safeAreaInsets
      tableView.dataSource = viewModel.dataSource
      tableView.delegate = self
    }

    @objc private func closeButtonTapped() {
      dismiss(animated: true, completion: nil)
    }
  }
}

extension DevCredRootView.Controller: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return .leastNormalMagnitude
  }

  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return .leastNormalMagnitude
  }

  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return nil
  }

  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return nil
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    guard let itemIdentifier = viewModel.dataSource?.itemIdentifier(for: indexPath) else { return }

    switch itemIdentifier {
    case .project(let devCredProjectInfo):
      guard let urlString = devCredProjectInfo.linkUrl,
            let url = URL(string: urlString) else { return }

      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    default:
      return
    }
  }
}
