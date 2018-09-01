//
//  ScheduledViewController.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class ScheduledViewController: UIViewController, Presentable {

    // MARK: - IBoutlets

    @IBOutlet private weak var tableView: UITableView!

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.Identifier.scheduledCell)
        let selector = #selector(editButtonHandler(_:))
        let sentButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: selector)
        navigationItem.rightBarButtonItem = sentButton
    }

    // MARK: - Control hanlers

    @objc private func editButtonHandler(_ sender: UIBarButtonItem) {

    }
}

// MARK: - UITableViewDataSource protocol conformace

extension ScheduledViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.scheduledCell, for: indexPath)
    }
}
