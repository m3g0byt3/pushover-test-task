//
//  HistoryViewController.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import EmptyDataSet_Swift

/// Message history scene.
final class HistoryViewController: UIViewController, Presentable {

    // MARK: - IBOutlets and UI

    @IBOutlet private weak var tableView: UITableView!

    private lazy var composeButton: UIBarButtonItem = {
        let selector = #selector(composeButtonHandler(_:))
        return UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: selector)
    }()

    // MARK: - Dependencies

    /// Service locator
    var configurator: Configurator<AppAssembly>?

    /// Database service, provides persistence
    var databaseService: AnyDatabaseService<HistoryItem>!
    // swiftlint:disable:previous implicitly_unwrapped_optional

    // MARK: - Private properties

    /// An array of immutable structs, represents sent messages.
    private var history = [HistoryItem]()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservation()
    }

    // MARK: - Private API

    /// Perform initial UI setup.
    private func setupUI() {
        navigationItem.rightBarButtonItem = composeButton
        tableView.register(R.nib.historyCell)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = Constants.HistoryScene.estimatedRowHeight
        tableView.emptyDataSetView { emptyDataSetView in
            emptyDataSetView.titleLabelString(Constants.HistoryScene.emptyTitle)
                            .detailLabelString(Constants.HistoryScene.emptyText)
        }
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

    /// Setup model observation for UI updates.
    private func setupObservation() {
        let keyPath = Constants.HistoryScene.sortKeyPath
        databaseService.observeChanges(sorted: .descending(keyPath: keyPath),
                                       predicate: nil,
                                       completion: { [weak self] history, diff in
                                            self?.history = history
                                            self?.tableView.apply(diff: diff)
        })
    }

    // MARK: - Control handlers

    /// Control handler for an `UIBarButtonItem` instance.
    /// - Parameter sender: `UIBarButtonItem` instance.
    @objc private func composeButtonHandler(_ sender: UIBarButtonItem) {
        let scene = configurator?.getScene(.compose(sender, configurator))
        guard let viewController = scene?.presentableEntity else { return }
        navigationController?.present(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource protocol conformace

extension HistoryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView
            // swiftlint:disable:next force_unwrapping
            .dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyCell, for: indexPath)!
            .configure(with: history[indexPath.row])
    }
}
