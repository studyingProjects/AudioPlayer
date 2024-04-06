//
//  PlaylistView.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

protocol PlaylistViewDelegate: AnyObject {
    func openPlayer(with songIndex: Int)
}

class PlaylistView: UIView {
    weak var delegate: PlaylistViewDelegate?

    private var playList: [SongProtocol]?
    private var songViews = [(view: UnderlinedView, viewModel: SongProtocol)]()
    // MARK: - Init
    init(with playlist: [SongProtocol]?) {
        super.init(frame: .zero)
        self.playList = playlist

        setupView()
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup View
    private func setupView() {
        backgroundColor = .appBackground
    }

    private func setupSubViews() {
        var priorView: UnderlinedView?

        guard let playList = playList else {
            return
        }

        for (index, song) in playList.enumerated() {
            // Prepare songView
            let songView = UnderlinedView(
                songTitle: song.title,
                songDuration: song.duration,
                songCover: song.cover,
                index: index
            )

            songView.delegate = self
            self.addSubviews(songView)
            // Setup constraints
            if let priorView = priorView {
                setupTopToPriorViewConstraint(from: songView, to: priorView)
            } else {
                setupTopToSuperViewConstraint(for: songView)
            }
            setupCommonConstraints(to: songView)

            self.songViews.append((songView, song))
            priorView = songView
        }
    }
}
// MARK: - Delegation
extension PlaylistView: UnderlinedViewDelegate {
    func openPlayer(with songIndex: Int) {
        delegate?.openPlayer(with: songIndex)
    }
}
// MARK: - Constraints
private extension PlaylistView {

    func setupTopToSuperViewConstraint(for view: UIView) {
        view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    }

    func setupTopToPriorViewConstraint(from currentView: UIView, to priorView: UIView) {
        currentView.topAnchor.constraint(
            equalTo: priorView.bottomAnchor,
            constant: Sizes.Small.padding
        ).isActive = true
    }

    func setupCommonConstraints(to view: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: Sizes.Medium.height)
        ])
    }
}
