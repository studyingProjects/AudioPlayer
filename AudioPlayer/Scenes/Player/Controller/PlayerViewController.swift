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
    private let playerView = PlayerView()

    // MARK: - LyfeCycle
    override func loadView() {
        playerView.delegate = self
        view = playerView
    }
}
// MARK: - Delegation
extension PlayerViewController: PlayerViewDelegate {
    // Plyaer controls
    func shuffle() {}

    func priorSong() {}

    func nextSong() {}

    func play() {
        player.play()
    }

    func pause() {}

    func repeatSong() {}
    // View managing
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
