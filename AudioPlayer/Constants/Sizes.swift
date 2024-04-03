//
//  Sizes.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

enum Sizes {
    enum XSmall {
        static let padding: CGFloat = 4
        static let width: CGFloat = 40
        static let height: CGFloat = 35
        static let cornerRadius: CGFloat = 5

        static let borderWidth: CGFloat = 0.5
        static let multiplier: CGFloat = 0.15
    }

    enum Small {
        static let padding: CGFloat = 8
        static let width: CGFloat = 50
        static let height: CGFloat = 35
        static let cornerRadius: CGFloat = 10

        static let borderWidth: CGFloat = 1
        static let multiplier: CGFloat = 0.25
    }

    enum Medium {
        static let padding: CGFloat = 16
        static let width: CGFloat = 100
        static let height: CGFloat = 70
        static let cornerRadius: CGFloat = 20

        static let borderWidth: CGFloat = 3
        static let multiplier: CGFloat = 0.5
    }

    enum Large {
        static let padding: CGFloat = 32
        static let width: CGFloat = 200
        static let height: CGFloat = 140
        static let cornerRadius: CGFloat = 30

        static let borderWidth: CGFloat = 6
        static let multiplier: CGFloat = 0.9
    }

    enum XLarge {
        static let padding: CGFloat = 64
        static let width: CGFloat = 400
        static let height: CGFloat = 280
        static let cornerRadius: CGFloat = 40

        static let borderWidth: CGFloat = 9
        static let multiplier: CGFloat = 0.95
    }
}
