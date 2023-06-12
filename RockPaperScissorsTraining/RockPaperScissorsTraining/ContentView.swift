//
//  ContentView.swift
//  RockPaperScissorsTraining
//
//  Created by Joey Rideout on 2023-06-12.
//

import SwiftUI

struct ContentView: View {
    enum Move: String, CaseIterable {
        case Rock = "🪨", Paper = "📜", Scissors = "✂️"
    }
    enum Goal: String, CaseIterable {
        case Win = "Win", Lose = "Lose"
    }

    @State private var opponentMove = Move.allCases[Int.random(in: 0...2)]
    @State private var yourGoal = Goal.Win
    @State private var score = 0
    @State private var showingEnd = false
    @State private var questionNumber = 1
    @State private var numQuestions = 10
    
    func toggleGoal() {
        if yourGoal == .Win {
            yourGoal = .Lose
        } else {
            yourGoal = .Win
        }
    }
    
    func shuffleOpponentMove() {
        opponentMove = Move.allCases[Int.random(in: 0...2)]
    }
    func reset() {
        showingEnd = false
        questionNumber = 1
        toggleGoal()
        shuffleOpponentMove()
        yourGoal = Goal.allCases[Int.random(in: 0...1)]
        score = 0
    }
    
    func moveTapped(_ move: Move) {
        if yourGoal == .Win {
            if  move != opponentMove && wins(playing: move, against: opponentMove) {
                score += 1
            }
        } else {
            if  move != opponentMove && !wins(playing: move, against: opponentMove) {
                score += 1
            }
        }
        
        if questionNumber < numQuestions {
            questionNumber += 1
            showingEnd = false
            toggleGoal()
            shuffleOpponentMove()
        } else {
            showingEnd = true
        }
    }
    
    func wins(playing: Move, against: Move) -> Bool {
        switch against {
        case .Rock:
            return playing == .Paper
        case .Paper:
            return playing == .Scissors
        case .Scissors:
            return playing == .Rock
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Opponent plays: \(opponentMove.rawValue)")
                .font(.system(size: 30))
            HStack(spacing: 0) {
                Text("Play to ")
                    .font(.system(.largeTitle))
                Text("\(yourGoal.rawValue)")
                    .font(.system(.largeTitle))
                    .foregroundColor(yourGoal == .Win ? .green : .red)
            }
            Text("Score: \(score)")
                .font(.system(.subheadline))
                .foregroundColor(.secondary)
            VStack(spacing: 20.0) {
                ForEach(Move.allCases, id: \.rawValue) { move in
                    Button {
                        moveTapped(move)
                    } label: {
                        Text("\(move.rawValue)")
                            .font(.system(size: 150))
                    }
                    
                }
            }
            .alert("Training Complete", isPresented: $showingEnd) {
                Button("Continue", action: reset)
            } message: {
                Text("Done! Your score is \(score). Restart game?")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
