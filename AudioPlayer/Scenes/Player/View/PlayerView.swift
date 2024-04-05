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

    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .systemGreen
        return slider
    }()

    private lazy var playerControlsStackView = PlayerControlsStackView()
    private lazy var deviceAvailableStackView = DevicesAvailableStackView()

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
        addSubviews(
            headerStackView,
            songDetailsStackView,
            slider,
            playerControlsStackView,
            deviceAvailableStackView
        )
    }
}
// MARK: - Constraints
private extension PlayerView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Header
            headerStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            // Details
            songDetailsStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            songDetailsStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            songDetailsStackView.bottomAnchor.constraint(
                equalTo: slider.topAnchor,
                constant: -Sizes.Medium.padding
            ),
            // Slider
            slider.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            slider.bottomAnchor.constraint(
                equalTo: playerControlsStackView.topAnchor,
                constant: -Sizes.Medium.padding
            ),
            // Player controls
            playerControlsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerControlsStackView.leadingAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leadingAnchor),
            playerControlsStackView.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor),
            playerControlsStackView.bottomAnchor.constraint(
                equalTo: deviceAvailableStackView.topAnchor,
                constant: -Sizes.Large.padding
            ),
            // Devices available
            deviceAvailableStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            deviceAvailableStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            deviceAvailableStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
