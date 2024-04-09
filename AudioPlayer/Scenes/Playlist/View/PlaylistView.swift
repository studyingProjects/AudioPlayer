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

    private lazy var playlistSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.isMomentary = false
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.addTarget(self, action: #selector(segmentTapped), for: .valueChanged)

        return segmentControl
    }()

    private lazy var colorSegmentControl: UISegmentedControl = {

        let blackAction = UIAction(
            title: "Black",
            handler: { _ in
                self.backgroundColor = .black
            }
        )

        let defaultAction = UIAction(
            title: "Default",
            handler: { _ in
                self.backgroundColor = .appBackground
            }
        )

        return UISegmentedControl(frame: .zero, actions: [blackAction, defaultAction])
    }()

    private var playList: [SongProtocol]?
    // private var songViews = [(view: UnderlinedView, viewModel: SongProtocol)]()
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

            // self.songViews.append((songView, song))
            priorView = songView
            // fill segments
            playlistSegmentControl.insertSegment(
                withTitle: song.title,
                at: index,
                animated: false
            )
        }

        self.addSubviews(playlistSegmentControl)
        setupPlaylistSegmenControl()

        // test control with UIAction
        self.addSubviews(colorSegmentControl)
        setupColorSegmentControl()
    }
    // MARK: - Action methods
    @objc
    private func segmentTapped(sender: UISegmentedControl) {
        delegate?.openPlayer(with: sender.selectedSegmentIndex)
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

    func setupPlaylistSegmenControl() {
        NSLayoutConstraint.activate([
            playlistSegmentControl.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            playlistSegmentControl.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            playlistSegmentControl.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -Sizes.Medium.padding
            )
        ])
    }

    func setupColorSegmentControl() {
        NSLayoutConstraint.activate([
            colorSegmentControl.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            colorSegmentControl.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            colorSegmentControl.bottomAnchor.constraint(
                equalTo: playlistSegmentControl.topAnchor,
                constant: -Sizes.Medium.padding
            )
        ])
    }
}
