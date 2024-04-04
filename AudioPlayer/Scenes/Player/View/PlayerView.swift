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
        addSubviews(headerStackView)
    }
}
// MARK: - Constraints
private extension PlayerView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
    }
}
