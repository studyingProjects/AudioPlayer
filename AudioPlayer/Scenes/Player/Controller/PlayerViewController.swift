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

        updateView()
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
    // MARK: - Helper methods
    private func updateView() {
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

    private func updateCurrentSong() {
        timer?.invalidate()
        updateView()
        delegate?.updateSongProgress(with: 0)
        if player.isPlaying() {
            play()
        } else {
            delegate?.sendPlayPauseUpdate()
        }
    }
}
// MARK: - Delegation
extension PlayerViewController: PlayerViewDelegate {
    func shareSong() {
        let activityController = UIActivityViewController(
            activityItems: [player.currentSong?.title ?? "nil"],
            applicationActivities: nil
        )

//        activityController.completionWithItemsHandler = { activity, success, items, error in
//            if success {
//                print("Successfully shared!")
//            } else {
//                print("Failed to share")
//            }
//        }

        activityController.excludedActivityTypes = [
            .postToTwitter,
            .postToWeibo,
            .message,
            .mail,
            .print,
            .copyToPasteboard,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .postToTencentWeibo
        ]

        self.present(activityController, animated: true)
    }

    func sliderChanged(with value: Float) {
        player.setCurrentTime(with: value)
    }

    // Plyaer controls
    func shuffle() {}

    func priorSong() {
        if player.priorSong() {
            updateCurrentSong()
        }
    }

    func nextSong() {
        if player.nextSong() {
            updateCurrentSong()
        }
    }

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
