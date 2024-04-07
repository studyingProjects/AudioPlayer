//
//  PlayerControlsStackView.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 04/04/2024.
//

import UIKit

protocol PlayerControlsStackViewDelegate: AnyObject {
    func shuffle()
    func priorSong()
    func nextSong()
    func play()
    func pause()
    func repeatSong()
}

class PlayerControlsStackView: UIStackView {
    weak var delegate: PlayerControlsStackViewDelegate?
    // MARK: - View Properties
    private var isPlayerActive = false
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
        scale: .medium,
        selectedImage: "pause.fill",
        type: .custom
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
        // Setup targets
        shuffleButton.addTarget(self, action: #selector(shuffle), for: .touchUpInside)
        backwardButton.addTarget(self, action: #selector(priorSong), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        repeatButton.addTarget(self, action: #selector(repeatSong), for: .touchUpInside)

        addArrangedSubview(shuffleButton)
        addArrangedSubview(backwardButton)
        addArrangedSubview(playPauseButton)
        addArrangedSubview(forwardButton)
        addArrangedSubview(repeatButton)
    }
    // MARK: - Public methods
    func playAfterViewAppeared() {
        playPause(playPauseButton)
    }
    // MARK: - Action methods
    @objc
    private func shuffle() {
        delegate?.shuffle()
    }

    @objc
    private func priorSong() {
        delegate?.priorSong()
    }

    @objc
    private func playPause(_ sender: UIButton) {
        // Change play/pause button image
        if sender.isSelected {
            delegate?.pause()
        } else {
            delegate?.play()
        }
        sender.isSelected = !sender.isSelected
    }

    @objc
    private func nextSong() {
        delegate?.nextSong()
    }

    @objc
    private func repeatSong() {
        delegate?.repeatSong()
    }
}
