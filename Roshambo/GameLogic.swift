//
//  GameLogic.swift
//  Roshambo
//
//  Created by o c e a n i c f a d e d on 18/02/2022.
//

import Foundation

// 1 = rock
// 2 = paper
// 3 = scissors

class GameLogic: ObservableObject {
    
    @Published var userScore = 0
    @Published var cpuScore = 0
    
    init(userScore:Int, cpuScore:Int) {
        self.userScore = userScore
        self.cpuScore = cpuScore
    }
    
    func fightLogic(userInput:Int, cpuInput:Int) -> Int {
        
        switch (userInput) {
        case 1:
            if cpuInput == 1 {
                print("DRAW")
                SoundManager.instance.playSound(sound: .draw)
                return 0
            } else if cpuInput == 2 {
                print("YOU LOSE")
                SoundManager.instance.playSound(sound: .paperWin)
                cpuScore += 1
                return 2
            } else if cpuInput == 3 {
                print("YOU WIN")
                SoundManager.instance.playSound(sound: .rockWin)
                userScore += 1
                return 1
            }
            break
        case 2:
            if cpuInput == 1 {
                print("YOU WIN")
                SoundManager.instance.playSound(sound: .paperWin)
                userScore += 1
                return 1
            } else if cpuInput == 2 {
                print("DRAW")
                SoundManager.instance.playSound(sound: .draw)
                return 0
            } else if cpuInput == 3 {
                print("YOU LOSE")
                SoundManager.instance.playSound(sound: .scissorsWin)
                cpuScore += 1
                return 2
            }
            break
        case 3:
            if cpuInput == 1 {
                print("YOU LOSE")
                SoundManager.instance.playSound(sound: .rockWin)
                cpuScore += 1
                return 2
            } else if cpuInput == 2 {
                print("YOU WIN")
                SoundManager.instance.playSound(sound: .scissorsWin)
                userScore += 1
                return 1
            } else if cpuInput == 3 {
                print("DRAW")
                SoundManager.instance.playSound(sound: .draw)
                return 0
            }
            break
        default:
            print("Error in userInput")
            return 0
        }
        return 0
    }
    
    func resetScore() {
        userScore = 0
        cpuScore = 0
    }
}
