//
//  PlayerViewController.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//
import UIKit

class PlayerViewController: UIViewController {
    weak var coordinator: Coordinator?

    private let player = AudioManager.shared
    
    override func loadView() {
        let playerView = PlayerView()
        playerView.delegate = self
        view = playerView
    }
}
// MARK: - Delegation
extension PlayerViewController: PlayerViewDelegate {
    func popCurrentView() {
        dismiss(animated: true)
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
