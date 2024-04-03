//
//  PlaylistView.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

class PlaylistView: UIView {
    private var playList: [SongProtocol]?
    private var songViews: [(view: UnderlinedView, viewModel: SongProtocol)]?
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
            let songView = UnderlinedView(songTitle: $0.songTitle, songDuration: $0.songDuration)
            self.addSubview(songView)

            if let priorView = priorView {
                setupTopToPriorViewConstraint(from: songView, to: priorView)
            } else {
                setupTopToSuperViewConstraint(for: songView)
            }
            setupCommonConstraints(to: songView)

            self.songViews?.append((songView, $0))
            priorView = songView
        }
    }
}
// MARK: - Constraints
private extension PlaylistView {

    func setupTopToSuperViewConstraint(for view: UIView) {
        view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    }

    func setupCommonConstraints(to view: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: Sizes.Large.height)
        ])
    }

    func setupTopToPriorViewConstraint(from currentView: UIView, to priorView: UIView) {
        currentView.topAnchor.constraint(
            equalTo: priorView.topAnchor,
            constant: Sizes.Small.padding
        ).isActive = true
    }
}
