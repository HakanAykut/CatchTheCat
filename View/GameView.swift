//
//  GameView.swift
//  CatchTheCat
//
//  Created by Hakan Aykut on 9.10.2024.
//
import SwiftUI

enum GameMode {
    case classic
    case progressive
    case focus
}

struct GameView: View {
    @StateObject var viewModel: GameViewModel
    @State private var showEndScreen = false
    @State private var selectedMode: GameMode? = nil  // Mod seçimi için

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        VStack {
            if selectedMode == nil {
                // Mod Seçim Ekranı
                VStack {
                    Text("Select Game Mode")
                        .font(.largeTitle)
                        .padding()

                    Button(action: {
                        selectedMode = .classic
                    }) {
                        Text("Classic Mode")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: {
                        selectedMode = .progressive
                    }) {
                        Text("Progressive Mode")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: {
                        selectedMode = .focus
                    }) {
                        Text("Focus Mode")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            } else if selectedMode == .classic {
                // Classic Mode Ekranı
                ZStack {
                    VStack {
                        Text("Time: \(viewModel.gameModel.timeRemaining)")
                            .font(.title)
                            .padding()

                        Text("Score: \(viewModel.gameModel.score)")
                            .font(.title)
                            .padding()

                        Spacer()

                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.kennyArray.indices, id: \.self) { index in
                                Image(systemName: viewModel.kennyArray[index] ? "pawprint.fill" : "pawprint")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .onTapGesture {
                                        viewModel.increaseScore()
                                    }
                                    .opacity(viewModel.kennyArray[index] ? 1 : 0)
                            }
                        }
                        .padding()

                        Spacer()
                    }
                    .onAppear {
                        viewModel.startGame()
                    }

                    if showEndScreen {
                        VStack(spacing: 20) {
                            Text("Time's Up!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("Your Score: \(viewModel.gameModel.score)")
                                .font(.title2)

                            HStack(spacing: 20) {
                                Button(action: {
                                    viewModel.startGame()
                                    showEndScreen = false
                                }) {
                                    Text("Replay")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }

                                Button(action: {
                                    selectedMode = nil  // Menüye dönüş
                                }) {
                                    Text("Back to Menu")
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding()
                    }
                }
                .onChange(of: viewModel.isGameOver) { newValue in
                    if newValue {
                        showEndScreen = true
                    }
                }
            }
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel(gameSpeed: 1.0))
}
