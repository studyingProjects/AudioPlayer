//
//  PlayerView.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

class PlayerView: UIView {
    // MARK: - View Properties
    private lazy var headerStackView = HeaderStackView()
    private lazy var songDetailsStackView = SongDetailsStackView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup View
    private func setupView() {
        backgroundColor = .appBackground
    }

    private func setupSubviews() {
        addSubviews(headerStackView, songDetailsStackView)
    }
}
// MARK: - Constraints
private extension PlayerView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // header
            headerStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            // details
            songDetailsStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            songDetailsStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            songDetailsStackView.topAnchor.constraint(
                equalTo: headerStackView.bottomAnchor,
                constant: Sizes.Medium.padding
            )
        ])
    }
}
