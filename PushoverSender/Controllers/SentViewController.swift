//
//  SentViewController.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

class SentViewController: UIViewController {

    // MARK: - IBoutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private API

    private func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.Identifier.sentCell)
        let selector = #selector(sentButtonHandler(_:))
        let sentButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: selector)
        navigationItem.rightBarButtonItem = sentButton
    }

    // MARK: - Control hanlers

    @objc private func sentButtonHandler(_ sender: UIBarButtonItem) {

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
