//
//  GameViewModel.swift
//  CatchTheCat
//
//  Created by Hakan Aykut on 9.10.2024.
//

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var gameModel = GameModel()
    @Published var isGameOver = false
    @Published var kennyArray: [Bool] = [Bool](repeating: false, count: 9)
    var gameSpeed: Double

    var timer = Timer()
    var hideTimer = Timer()

    init(gameSpeed: Double = 1.0) {
        self.gameSpeed = gameSpeed
    }

    func startGame() {
        gameModel.score = 0
        gameModel.timeRemaining = 20
        isGameOver = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTime()
        }
        
        hideTimer = Timer.scheduledTimer(withTimeInterval: gameSpeed, repeats: true) { _ in
            self.hideKenny()
            print(self.gameSpeed)  // Hız kontrolü için log
        }
    }

    func hideKenny() {
        for i in kennyArray.indices {
            kennyArray[i] = false
        }
        let randomIndex = Int.random(in: 0..<kennyArray.count)
        kennyArray[randomIndex] = true
    }

    func updateTime() {
        if gameModel.timeRemaining > 0 {
            gameModel.timeRemaining -= 1
        } else {
            endGame()
        }
    }

    func increaseScore() {
        gameModel.score += 1
    }

    func endGame() {
        timer.invalidate()
        hideTimer.invalidate()
        if gameModel.score > gameModel.highScore {
            gameModel.highScore = gameModel.score
            UserDefaults.standard.set(gameModel.highScore, forKey: "highscore")
        }
        isGameOver = true
    }
}
