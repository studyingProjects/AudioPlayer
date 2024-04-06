//
//  PlaylistView.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

protocol PlaylistViewDelegate: AnyObject {
    func openPlayer()
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

        playList?.forEach {
            // Prepare songView
            let songView = UnderlinedView(
                songTitle: $0.title,
                songDuration: $0.duration,
                songCover: $0.cover
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

            self.songViews.append((songView, $0))
            priorView = songView
        }
    }
}
// MARK: - Delegation
extension PlaylistView: UnderlinedViewDelegate {
    func openPlayer() {
        delegate?.openPlayer()
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
