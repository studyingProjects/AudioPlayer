//
//  UILabel+App.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

extension UILabel {
    convenience init(
        text: String? = "",
        font: UIFont = .appMediumFont,
        color: UIColor = .appMinorControls,
        aligment: NSTextAlignment = .natural
    ) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color

        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }
}
