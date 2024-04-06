//
//  AudioManager.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 05/04/2024.
//

import AVFoundation
import UIKit

protocol PlaylistManagerProtocol {
    func getPlaylist() -> [SongProtocol]?
    func loadPlaylist()
}

enum PlaylistError: Error {
    case fileNotFound
}

final class AudioManager {
    static let shared = AudioManager()

    private var player: AVPlayer?
    private var playlist: [SongProtocol]?

    private init() {
        loadPlaylist()
    }
}
// MARK: - PlaylistManager
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

    func getSongCredentials(songURL: URL) -> SongProtocol {
        let asset = AVAsset(url: songURL)
        var song = SongModel()

        let metadata = asset.commonMetadata
        for item in metadata {
            if let value = item.value {
                switch item.commonKey {
                case AVMetadataKey.commonKeyTitle:
                    song.title = value as? String
                case AVMetadataKey.commonKeyArtist:
                    song.artist = value as? String
                case AVMetadataKey.commonKeyAlbumName:
                    song.album = value as? String
                case AVMetadataKey.commonKeyArtwork:
                    if let dataValue = value as? Data,
                       let audioImage = UIImage(data: dataValue) {
                        song.cover = audioImage
                    }
                default:
                    break
                }
            }
        }

        song.duration = asset.duration.displayTime

        return song
    }
// MARK: - Load Playlist
    func loadPlaylist() {

        var arrayOfSongs = [SongProtocol]()

        do {
            let firstSongURL = try loadFile(forResource: "01. Fire (Remix 2024)", withExtension: "mp3")
            let firstSong = getSongCredentials(songURL: firstSongURL)
            // let firstSong = SongModel(songTitle: "First song", songDuration: "4:20", songURL: firstSongURL)

            arrayOfSongs.append(firstSong)
        } catch {}
        do {
            let secondSongURL = try loadFile(forResource: "02. Let's Dance Tonight", withExtension: "mp3")
            let secondSong = getSongCredentials(songURL: secondSongURL)

            arrayOfSongs.append(secondSong)
        } catch {}

        do {
            let thirdSongURL = try loadFile(forResource: "03. Burning Heart", withExtension: "mp3")
            let thirdSong = getSongCredentials(songURL: thirdSongURL)
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
// MARK: - PlaylistError
extension PlaylistError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fileNotFound:
            return "File not found"
        }
    }
}
