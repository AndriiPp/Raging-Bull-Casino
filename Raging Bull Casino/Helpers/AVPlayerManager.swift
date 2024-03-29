//
//  AVPlayerManager.swift
//  Raging Bull Casino
//
//  Created by Nutella on 16.12.2021.
//

import UIKit
import AVFoundation

public let backgroundPlayer = AVPlayerManager.shared
public final class AVPlayerManager: NSObject {
    
    static let shared = AVPlayerManager()
    
    var player: AVAudioPlayer? = nil
    
    private override init() {
        guard let url = Bundle.main.path(forResource: "JWL_AmbiGeneral", ofType: "wav") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
        } catch {
            return
        }
    }
    
    func cheer() { player?.play() }
    func stop() { player?.stop()}
}
