//
//  UnderlinedView.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

protocol UnderlinedViewDelegate: AnyObject {
    func openPlayer()
}

class UnderlinedView: UIView {
    weak var delegate: UnderlinedViewDelegate?

    private let underlinedLayer = CALayer()
    private lazy var playImageView = UIImageView.getPlaySmallImageView()
    private lazy var songTitleLabel = UILabel(
        text: "Untitled",
        font: .appMediumBoldFont,
        color: .appMajorControls
    )
    private lazy var songDurationLabel = UILabel(
        text: "00:00",
        font: .appSmallFont,
        color: .appMinorControls
    )
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.addSublayer(underlinedLayer)
        setupView()
        setupSubViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(
        songTitle: String? = "Untitled",
        songDuration: String? = "00:00",
        songCover: UIImage?
    ) {
        self.init()
        songTitleLabel.text = songTitle
        songDurationLabel.text = songDuration
        if let image = songCover {
            playImageView.image = image
        }
    }

    // MARK: - LyfeCycle
    override func layoutSubviews() {
        super.layoutSubviews()

        setupUnderlinedLayer()
    }
    // MARK: - Setup view
    private func setupView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openPlayer))
        addGestureRecognizer(gesture)
    }

    private func setupSubViews() {
        addSubviews(playImageView, songTitleLabel, songDurationLabel)
    }

    private func setupUnderlinedLayer() {
        var frame = self.bounds
        frame.origin.y = frame.height - 1
        frame.size.height = 1
        underlinedLayer.borderWidth = 3

        underlinedLayer.frame = frame
        underlinedLayer.borderColor = UIColor.systemGray2.cgColor
    }
    // MARK: - Action methods
    @objc
    private func openPlayer() {
        delegate?.openPlayer()
    }
}
// MARK: - Constraints
private extension UnderlinedView {
    func setupConstraints() {
        setupPlayImageView()
        setupSongTitleLabel()
        setupSongDurationLabel()
        setupPriorities()
    }

    func setupPlayImageView() {
        NSLayoutConstraint.activate([
            playImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: Sizes.XSmall.padding
            ),
            playImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playImageView.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: Sizes.Large.multiplier
            ),
            playImageView.widthAnchor.constraint(equalTo: playImageView.heightAnchor)
        ])
    }

    func setupSongTitleLabel() {
        NSLayoutConstraint.activate([
            songTitleLabel.leadingAnchor.constraint(
                equalTo: playImageView.trailingAnchor,
                constant: Sizes.XSmall.padding
            ),
            songTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupSongDurationLabel() {
        NSLayoutConstraint.activate([
            songDurationLabel.leadingAnchor.constraint(
                equalTo: songTitleLabel.trailingAnchor,
                constant: Sizes.XSmall.padding
            ),
            songDurationLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Sizes.XSmall.padding
            ),
            songDurationLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupPriorities() {
        songDurationLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}
