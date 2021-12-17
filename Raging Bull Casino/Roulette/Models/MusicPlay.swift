//
//  MusicPlay.swift
//  Raging Bull Casino
//
//  Created by Nutella on 17.12.2021.
//

import Foundation
import AVFoundation

class MusicPlay{
    let loopCount = -1
    var audioPlayer: AVAudioPlayer?
    var musicName : String!
    var musicType : String!
    init(MusicName musicName : String, MusicType musicType : String = "mp3") {
        self.musicName = musicName
        self.musicType = musicType
    }
    func startMusic(){
        if let bundle = Bundle.main.path(forResource: musicName, ofType: musicType) {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = loopCount
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                adjustMusic(Volume: 0.4)
            } catch {
                print(error)
            }
        }
    }
    func startOneTimeMusic(){
        if let bundle = Bundle.main.path(forResource: musicName, ofType: musicType) {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = 0
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    func stopMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
    func adjustMusic(Volume vol : Float){
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.volume = vol
    }
}
