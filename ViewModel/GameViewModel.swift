//
//  GameViewModel.swift
//  CatchTheCat
//
//  Created by Hakan Aykut on 9.10.2024.
//
import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var gameModel = GameModel()
    @Published var kennyArray: [Bool] = Array(repeating: false, count: 9)
    @Published var isGameOver = false
    var gameSpeed: Double  // Yeni parametre
    var timer: Timer?
    var hideTimer: Timer?

    init(gameSpeed: Double) {  // gameSpeed'i alan init fonksiyonu
        self.gameSpeed = gameSpeed
    }

    func startGame() {
        gameModel.score = 0
        gameModel.timeRemaining = 20
        isGameOver = false

        // Geri sayım
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.gameModel.timeRemaining > 0 {
                self.gameModel.timeRemaining -= 1
            } else {
                self.endGame()
            }
        }

        // Sembollerin kaybolup görünmesi
        hideTimer = Timer.scheduledTimer(withTimeInterval: gameSpeed, repeats: true) { _ in
            self.hideAndShowKenny()
        }
    }

    func hideAndShowKenny() {
        for i in 0..<kennyArray.count {
            kennyArray[i] = false
        }
        let randomIndex = Int.random(in: 0..<kennyArray.count)
        kennyArray[randomIndex] = true
    }

    func increaseScore() {
        gameModel.score += 1
    }

    func endGame() {
        timer?.invalidate()
        hideTimer?.invalidate()
        isGameOver = true
    }
}
