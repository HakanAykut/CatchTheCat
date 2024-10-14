//
//  OpenView.swift
//  CatchTheCat
//
//  Created by Hakan Aykut on 9.10.2024.
//

import SwiftUI

struct OpenView: View {
    @State private var gameSpeed: Double = 1.0
    @State private var showLevelView = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Catch the Cat!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                NavigationLink(destination: GameView(viewModel: GameViewModel(gameSpeed: gameSpeed))) {
                    Text("Start Game")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)

                Button("Select Difficulty") {
                    showLevelView = true
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $showLevelView) {
                    LevelView(selectedSpeed: $gameSpeed)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
#Preview {
    OpenView()
}
