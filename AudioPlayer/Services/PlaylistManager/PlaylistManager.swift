//
//  PlaylistManager.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import Foundation

protocol PlaylistManagerProtocol {
    func getPlaylist() -> [SongProtocol]?
}

class PlaylistManager: PlaylistManagerProtocol {
    static let shared = PlaylistManager()

    private init() {}

    func getPlaylist() -> [SongProtocol]? {
        let firstSong = SongModel(songTitle: "First song", songDuration: "4:20")
        let secondSong = SongModel(songTitle: "Second song", songDuration: "4:20")

        return [firstSong, secondSong]
    }
}
