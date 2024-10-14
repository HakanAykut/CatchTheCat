//
//  GameModel.swift
//  CatchTheCat
//
//  Created by Hakan Aykut on 9.10.2024.
//
import SwiftUI
import Foundation

struct GameModel {
    var score: Int = 0
    var highScore: Int = UserDefaults.standard.integer(forKey: "highscore")
    var timeRemaining: Int = 20
}
