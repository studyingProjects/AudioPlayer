//
//  PlaylistModel.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import Foundation

protocol SongProtocol {
    var songTitle: String? { get set }
    var songDuration: String? { get set }
    var songCover: String? { get set }
    var songURL: URL? { get set }
}

struct SongModel: SongProtocol {
    var songTitle: String?
    var songDuration: String?
    var songCover: String?
    var songURL: URL?
}
