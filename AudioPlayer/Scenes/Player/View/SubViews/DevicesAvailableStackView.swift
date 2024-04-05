//
//  DevicesAvailableStackView.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 05/04/2024.
//

import UIKit

class DevicesAvailableStackView: UIStackView {
    private lazy var deviceIcon: UIImageView = {
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .gray)
        let playImage = UIImage(systemName: "display", withConfiguration: config)
        let imageView = UIImageView(image: playImage)
        imageView.layer.masksToBounds = true
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var devicesAvailableLabel = UILabel(
        text: "Devices available",
        font: .appSmallFont,
        color: .appMinorControls
    )

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
        axis = .vertical
        alignment = .center
        distribution = .fillEqually
        spacing = Sizes.Small.padding
    }

    private func setupSubViews() {
        addArrangedSubview(deviceIcon)
        addArrangedSubview(devicesAvailableLabel)
    }
}
