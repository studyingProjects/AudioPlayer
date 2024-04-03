//
//  UIImageView+App.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

extension UIImageView {
    static func getPlaySmallImageView() -> UIImageView {
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .black)
        let playImage = UIImage(systemName: "play.square.fill", withConfiguration: config)
        let imageView = UIImageView(image: playImage)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit

        return imageView
    }
}
