//
//  AudioManager.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 05/04/2024.
//

import AVFoundation

protocol PlaylistManagerProtocol {
    func getPlaylist() -> [SongProtocol]?
    func loadFile(forResource: String?, withExtension: String?) throws -> URL
    func loadPlaylist()
}

enum PlaylistError: Error {
    case fileNotFound
}

final class AudioManager {
    static let shared = AudioManager()

    private var player: AVPlayer?
    private var playlist: [SongProtocol]?

    private init() {}
}

extension AudioManager: PlaylistManagerProtocol {

    func loadFile(forResource: String?, withExtension: String?) throws -> URL {
        guard let soundFileURL = Bundle.main.url(
            forResource: forResource,
            withExtension: withExtension
        ) else {
            throw PlaylistError.fileNotFound
        }

        return soundFileURL
    }

    func loadPlaylist() {

        var arrayOfSongs = [SongProtocol]()

        do {
            let firstSongURL = try loadFile(forResource: "01. Fire (Remix 2024)", withExtension: "mp3")
            // let asset = AVAsset(NSURL(fileURLWithPath: firstSongURL)
            let firstSong = SongModel(songTitle: "First song", songDuration: "4:20", songURL: firstSongURL)

            arrayOfSongs.append(firstSong)
        } catch {}
        do {
            let secondSongURL = try loadFile(forResource: "01. Fire (Remix 2024)", withExtension: "mp3")
            let secondSong = SongModel(songTitle: "Second song", songDuration: "4:20", songURL: secondSongURL)

            arrayOfSongs.append(secondSong)
        } catch {}

        do {
            let thirdSongURL = try loadFile(forResource: "01. Fire (Remix 2024)", withExtension: "mp3")
            let thirdSong = SongModel(songTitle: "Third song", songDuration: "4:20", songURL: thirdSongURL)

            arrayOfSongs.append(thirdSong)
        } catch {}

        if !arrayOfSongs.isEmpty {
            playlist = arrayOfSongs
        }
    }

    func getPlaylist() -> [SongProtocol]? {
        return playlist
    }
}

extension PlaylistError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fileNotFound:
            return "File not found"
        }
    }
}
