//
//  UIButton+App.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 04/04/2024.
//

import UIKit

extension UIButton {
    convenience init(
        title: String?,
        font: UIFont? = nil,
        titleColor: UIColor? = nil,
        backGroundColor: UIColor? = nil,
        cornerRadius: CGFloat = 0
    ) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(UIColor.tintColor, for: .highlighted)
        self.backgroundColor = backGroundColor
        self.layer.cornerRadius = cornerRadius
    }

    convenience init(
        image: String,
        isMajorImage: Bool = false,
        pointSize: CGFloat? = nil,
        scale: UIImage.SymbolScale = .default
    ) {
        self.init(type: .system)
        // Adjust image
        var majorConfig = UIImage.SymbolConfiguration(hierarchicalColor: .black)
        var minorConfig = UIImage.SymbolConfiguration(hierarchicalColor: .gray)
        // Scaling
        if let pointSize = pointSize {
            let scaleConfig = UIImage.SymbolConfiguration(
                pointSize: pointSize,
                weight: .regular,
                scale: scale
            )
            majorConfig = majorConfig.applying(scaleConfig)
            minorConfig = majorConfig.applying(scaleConfig)
        }
        // Get images
        let majorImage = UIImage(systemName: image, withConfiguration: majorConfig)
        let minorImage = UIImage(systemName: image, withConfiguration: minorConfig)

        if isMajorImage {
            self.setImage(majorImage, for: .normal)
            self.setImage(minorImage, for: .highlighted)
        } else {
            self.setImage(minorImage, for: .normal)
            self.setImage(majorImage, for: .highlighted)
        }
    }
}
