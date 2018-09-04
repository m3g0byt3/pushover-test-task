//
//  HistoryCell.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class HistoryCell: UITableViewCell {

    // MARK: - Constants

    /// 24h timeinterval in seconds.
    private static let oneDay: TimeInterval = 60.0 * 60.0 * 24.0

    /// Formatter to format date label text.
    private static let formatter = DateFormatter()

    // MARK: - Typealiases

    /// Date and time styles for `DateFormatter`.
    private typealias Style = (time: DateFormatter.Style, date: DateFormatter.Style)

    // MARK: - IBOutlets and UI

    @IBOutlet private weak var statusImage: UIImageView!
    @IBOutlet private weak var dateTimeLabel: UILabel!
    @IBOutlet private weak var messageTitleLabel: UILabel!
    @IBOutlet private weak var messageTextLabel: UILabel!
    @IBOutlet private weak var recipientLabel: UILabel!

    // MARK: - Public API

    override func prepareForReuse() {
        super.prepareForReuse()
        statusImage.image = nil
        dateTimeLabel.text = nil
        messageTitleLabel.text = nil
        messageTextLabel.text = nil
        recipientLabel.text = nil
    }

    // MARK: - Private API

    /// String representation of date.
    /// - Parameter date: Given date.
    /// - Returns: Short time (e.g. 00:00) when `HistoryCell.oneDay`
    /// is not elapsed since given date, otherwise returns short date (e.g. 01/01/01).
    private static func dateStyle(for date: Date) -> Style {
        if Date().timeIntervalSince(date) < HistoryCell.oneDay {
            return (time: .short, date: .none)
        }
        return (time: .none, date: .short)
    }
}

// MARK: - Configurable protocol conformance

extension HistoryCell: Configurable {

    typealias Model = HistoryItem

    func configure(with model: Model) -> Self {
        let date = model.date
        let format = HistoryCell.dateStyle(for: date)
        let formatter = HistoryCell.formatter

        formatter.dateStyle = format.date
        formatter.timeStyle = format.time

        statusImage.image = model.isSuccessful ? R.image.success() : R.image.failed()
        dateTimeLabel.text = formatter.string(from: date)
        messageTitleLabel.text = model.message.title
        messageTitleLabel.isHidden = model.message.title.isEmpty
        messageTextLabel.text = model.message.text
        recipientLabel.text = Constants.HistoryScene.recipientPrefix + model.message.recipient.key

        return self
    }
}
