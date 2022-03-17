//
//  AudioPlayer.swift
//  WyK Mediate (iOS)
//
//  Created by Wykee Njenga on 11/26/21.
//

import Foundation
import AVFoundation


var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("Can't play")
        }
    }
}
