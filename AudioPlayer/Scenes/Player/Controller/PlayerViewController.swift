//
//  PlayerViewController.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//
import UIKit

protocol PlayerViewControllerDelegate: AnyObject {
    func playAfterViewAppeared()
}

class PlayerViewController: UIViewController {
    weak var coordinator: Coordinator?
    weak var delegate: PlayerViewControllerDelegate?

    private let player = AudioManager.shared
    private let playerView = PlayerView()

    // MARK: - LyfeCycle
    override func loadView() {
        playerView.delegate = self
        self.delegate = playerView
        view = playerView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.playAfterViewAppeared()
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

    func pause() {
        player.pause()
    }

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
