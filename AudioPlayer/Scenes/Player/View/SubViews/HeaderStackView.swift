//
//  Header.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 04/04/2024.
//

import UIKit

class HeaderStackView: UIStackView {
    // MARK: - View Properties
    private lazy var leftButton = UIButton(image: "chevron.down")
    private lazy var minorTitle = UILabel(
        text: "Playing from album",
        font: .appSmallFont,
        color: .appMinorControls
    )
    private lazy var majorTitle = UILabel(
        text: "The title of Album",
        font: .appSmallBoldFont,
        color: .appMajorControls
    )
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minorTitle, majorTitle])
        stackView.axis = .vertical
        stackView.spacing = Sizes.XSmall.padding
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = .center

        return stackView
    }()
    private lazy var rightButton = UIButton(image: "square.and.arrow.up")
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
        spacing = Sizes.XSmall.padding
        distribution = .fill
        alignment = .center
        isLayoutMarginsRelativeArrangement = true
    }

    private func setupSubViews() {
        addArrangedSubview(leftButton)
        addArrangedSubview(titleStackView)
        addArrangedSubview(rightButton)
    }
}
