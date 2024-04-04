//
//  PlayerViewController.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

class PlayerViewController: UIViewController {
    weak var coordinator: Coordinator?

    override func loadView() {
        view = PlayerView()
    }
}

import SwiftUI
struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        Group {
            // change to your vc
            PlayerViewController().preview()
        }
    }
}
