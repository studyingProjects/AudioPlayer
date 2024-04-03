//
//  UIView+App.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

extension UIView {
    convenience init(cornerRadius: CGFloat = 0, backGroundColor: UIColor? = .clear) {
        self.init(frame: .zero)
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backGroundColor
    }

    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
