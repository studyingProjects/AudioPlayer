//
//  PlayerControlsStackView.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 04/04/2024.
//

import UIKit

class PlayerControlsStackView: UIStackView {
    // MARK: - View Properties
    private lazy var shuffleButton = UIButton(image: "shuffle")
    private lazy var backwardButton = UIButton(
        image: "backward.end.fill",
        isMajorImage: true,
        pointSize: Sizes.Medium.height,
        scale: .small
    )
    private lazy var playPauseButton = UIButton(
        image: "play.fill",
        isMajorImage: true,
        pointSize: Sizes.Medium.height,
        scale: .medium
    )
    private lazy var forwardButton = UIButton(
        image: "forward.end.fill",
        isMajorImage: true,
        pointSize: Sizes.Medium.height,
        scale: .small
    )
    private lazy var repeatButton = UIButton(image: "repeat")
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupSubViews()
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup View
    private func setupView() {
        axis = .horizontal
        spacing = Sizes.Large.padding
        distribution = .fillEqually
        alignment = .center
        isLayoutMarginsRelativeArrangement = true
    }

    private func setupSubViews() {
        addArrangedSubview(shuffleButton)
        addArrangedSubview(backwardButton)
        addArrangedSubview(playPauseButton)
        addArrangedSubview(forwardButton)
        addArrangedSubview(repeatButton)
    }
}
private extension PlayerControlsStackView {
    func setupConstraints() {}
}
