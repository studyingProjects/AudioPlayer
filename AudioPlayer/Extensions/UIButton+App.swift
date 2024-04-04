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
        cornerRadius: CGFloat = 0,
        image: String? = nil,
        isMajorImage: Bool? = false
    ) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(UIColor.tintColor, for: .highlighted)
        self.backgroundColor = backGroundColor
        self.layer.cornerRadius = cornerRadius
        // adjust image
        if let image = image {
            let majorConfig = UIImage.SymbolConfiguration(hierarchicalColor: .black)
            let minorConfig = UIImage.SymbolConfiguration(hierarchicalColor: .gray)
            let majorImage = UIImage(systemName: image, withConfiguration: majorConfig)
            let minorImage = UIImage(systemName: image, withConfiguration: minorConfig)

            if let isMajorImage = isMajorImage, isMajorImage {
                self.setImage(majorImage, for: .normal)
                self.setImage(minorImage, for: .highlighted)
            } else {
                self.setImage(minorImage, for: .normal)
                self.setImage(majorImage, for: .highlighted)
            }
        }
    }
}
