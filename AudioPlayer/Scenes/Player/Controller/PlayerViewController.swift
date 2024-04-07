//
//  PlayerViewController.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//
import UIKit

protocol PlayerViewControllerDelegate: AnyObject {
    func updateView(
        album: String?,
        song: String?,
        cover: UIImage?,
        duration: String?,
        durationFloat: Float?
    )
    func playAfterViewAppeared()
}

class PlayerViewController: UIViewController {
    weak var coordinator: Coordinator?
    weak var delegate: PlayerViewControllerDelegate?

    private let player = AudioManager.shared
    private var playerView = PlayerView()

    // MARK: - LyfeCycle
    override func loadView() {
        playerView.delegate = self
        view = playerView
        self.delegate = playerView

        if let currentSong = player.currentSong {
            delegate?.updateView(
                album: currentSong.album,
                song: currentSong.title,
                cover: currentSong.cover,
                duration: currentSong.duration,
                durationFloat: currentSong.durationFloat
            )
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.playAfterViewAppeared()
    }
}
// MARK: - Delegation
extension PlayerViewController: PlayerViewDelegate {
    func sliderChanged(with value: Float) {
        player.setCurrentTime(with: value)
    }

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
