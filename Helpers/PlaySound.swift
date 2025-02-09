//
//  PlaySound.swift
//  SlotMachine
//
//  Created by Muhammet Eren on 8.02.2025.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound:String,type:String){
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch  {
            print(error.localizedDescription)
        }
    }
}
