//
//  PlaylistViewController.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

class PlaylistViewController: UIViewController {
    weak var coordinator: Coordinator?

    private let playlistManager = PlaylistManager.shared
    private var playlistView: PlaylistView?
    private var playList: [SongProtocol]?

    override func loadView() {
        playList = playlistManager.getPlaylist()
        playlistView = PlaylistView(with: playList)
        playlistView?.delegate = self

        view = playlistView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
        setupNavigationAppearance()
    }

    private func setupViewController() {
        title = "Plist"
    }

    private func setupNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.viewControllerTitleColor]
        navigationController?.navigationBar.standardAppearance = appearance
    }
}
// MARK: - Delegation
extension PlaylistViewController: PlaylistViewDelegate {
    func openPlayer() {
        coordinator?.openPlayer()
    }
}
