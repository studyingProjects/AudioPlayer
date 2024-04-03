//
//  PlaylistViewController.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

class PlaylistViewController: UIViewController {
    weak var coordinator: Coordinator?

    private let playlistView = PlaylistView()

    override func loadView() {
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

import SwiftUI
struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        Group {
            // change to your vc
            PlaylistViewController().preview()
        }
    }
}
