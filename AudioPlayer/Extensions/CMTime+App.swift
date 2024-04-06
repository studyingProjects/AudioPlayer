//
//  CMTime+App.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 06/04/2024.
//
import AVFoundation

extension CMTime {
    var displayTime: String? {
        guard let sec = seconds?.rounded() else { return nil }

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        if sec < 60 * 60 {
            formatter.allowedUnits = [.minute, .second]
        } else {
            formatter.allowedUnits = [.hour, .minute, .second]
        }
        return formatter.string(from: sec) ?? nil
    }

    var seconds: Double? {
        let time = CMTimeGetSeconds(self)
        guard time.isNaN == false else { return nil }
        return time
    }
}
