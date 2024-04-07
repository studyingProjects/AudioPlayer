//
//  AudioManager.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 05/04/2024.
//

import AVFoundation
import UIKit

protocol PlaylistManagerProtocol: AnyObject {

    func getPlaylist() -> [SongProtocol]?
    func setCurrentSongIndex(with index: Int)
}

protocol PlayerControlsProtocol: AnyObject {
    func play()
    func pause()
}

enum PlaylistError: Error {
    case fileNotFound
}

final class AudioManager {
    static let shared = AudioManager()

    private var player: AVAudioPlayer?
    private var playlist: [SongProtocol]?
    // Index of current song
    private var songIndex: Int?

    private init() {
        loadPlaylist()
    }
}
// MARK: - PlayerControls
extension AudioManager: PlayerControlsProtocol {
    func play() {

        guard let songIndex = songIndex,
              let currentSongURL = playlist?[songIndex].songURL else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: currentSongURL)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func pause() {
        guard let player = player else { return }

        player.pause()
    }
}
// MARK: - Load Playlist
extension AudioManager {
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

        song.songURL = songURL
        song.duration = asset.duration.displayTime

        return song
    }
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
}
// MARK: - PlaylistManager
extension AudioManager: PlaylistManagerProtocol {

    func getPlaylist() -> [SongProtocol]? {
        return playlist
    }

    func setCurrentSongIndex(with index: Int) {
        self.songIndex = index
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
