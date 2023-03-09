//
//  ModelData.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/13/22.
//

import Foundation
import Combine
import Amplify
import AVKit

final class ModelData: ObservableObject {
    @Published var numbers: [Number] = load("numbers.json")
    @Published var colors: [CColor] = load("colors.json")
    @Published var naturals: [Natural] = load("naturals.json")
    @Published var shapes: [Shape] = load("shapes.json")
    @Published var phrases: [Phrase] = load("phrases.json")
    
    var store: [StoreItem] = load("store.json")
    @Published var profile = Profile.default
}

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    enum SoundOptions: String {
        case yes
        case no
        case cash
    }
    func playSound(sound: SoundOptions) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound \(error.localizedDescription)")
        }
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
