//
//  PlaylistModel.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

protocol SongProtocol {
    var title: String? { get set }
    var artist: String? { get set }
    var album: String? { get set }
    var duration: String? { get set }
    var cover: UIImage? { get set }
    var songURL: URL? { get set }
}

struct SongModel: SongProtocol {
    var title: String?
    var artist: String?
    var album: String?
    var duration: String?
    var cover: UIImage?
    var songURL: URL?
}
