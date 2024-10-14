//
//  LevelView.swift
//  CatchTheCat
//
//  Created by Hakan Aykut on 10.10.2024.
//

import SwiftUI

struct LevelView: View {
    @Binding var selectedSpeed: Double
    @Environment(\.presentationMode) var presentationMode
    
    let difficultyLevels: [(String, Double)] = [
        ("Very Easy", 1.5),
        ("Easy", 1.25),
        ("Normal", 1.0),
        ("Hard", 0.75),
        ("Very Hard", 0.5)
    ]
    
    var body: some View {
        VStack {
            Text("Select Difficulty Level")
                .font(.largeTitle)
                .padding()

            ForEach(difficultyLevels, id: \.1) { level in
                Button(action: {
                    selectedSpeed = level.1
                }) {
                    HStack {
                        Text(level.0)
                        Spacer()
                        if selectedSpeed == level.1 {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top)
        }
    }
}
