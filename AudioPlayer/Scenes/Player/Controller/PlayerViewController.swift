//
//  PlayerViewController.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//
import UIKit

protocol PlayerViewControllerDelegate: AnyObject {

    func updateSongProgress(with value: Float)

    func updateView(
        album: String?,
        song: String?,
        cover: UIImage?,
        duration: String?,
        durationFloat: Float?
    )

    func sendPlayPauseUpdate()
}

class PlayerViewController: UIViewController {
    weak var coordinator: Coordinator?
    weak var delegate: PlayerViewControllerDelegate?

    private var timer: Timer?
    private var songDuration: Float?
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

            songDuration = currentSong.durationFloat
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.sendPlayPauseUpdate()
    }
    // MARK: - Action methods
    @objc private func updateSongProgress() {
        let currentTime = player.getCurrentTime()
        delegate?.updateSongProgress(with: currentTime)

        if currentTime == 0 || currentTime >= songDuration ?? 0 {
            delegate?.sendPlayPauseUpdate()
        }
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

        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateSongProgress),
            userInfo: nil,
            repeats: true
        )
    }

    func pause() {
        player.pause()

        timer?.invalidate()
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
