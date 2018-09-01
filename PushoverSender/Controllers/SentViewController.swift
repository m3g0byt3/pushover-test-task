//
//  SentViewController.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class SentViewController: UIViewController, Presentable {

    // MARK: - IBoutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Private properties

    var configurator: Configurator<AppAssembly>?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private API

    private func setupUI() {
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.Identifier.sentCell)
        let selector = #selector(composeButtonHandler(_:))
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: selector)
        navigationItem.rightBarButtonItem = composeButton
    }

    // MARK: - Control hanlers

    @objc private func composeButtonHandler(_ sender: UIBarButtonItem) {
        let scene = configurator?.getScene(.compose(sender))
        guard let viewController = scene?.presentableEntity else { return }
        navigationController?.present(viewController, animated: true)
    }
}

// MARK: UITableViewDataSource protocol conformace

extension SentViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.sentCell, for: indexPath)
    }
}
