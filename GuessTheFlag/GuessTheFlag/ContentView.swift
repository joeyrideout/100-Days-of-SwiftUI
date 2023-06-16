//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Joey Rideout on 2023-06-09.
//

import SwiftUI

struct FlagImage: View {
    var image: String

    var body: some View {
        Image(image)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var questionNumber = 1
    @State private var maxQuestions = 8
    
    @State private var showingScore = false
    @State private var showingEnd = false
    @State private var scoreTitle = ""
    
    @State private var flagToAnimate = -1
    @State private var flagRotationValues = [0.0, 0.0, 0.0]
    @State private var flagOpacityValues = [1.0, 1.0, 1.0]
    @State private var flagScaleValues = [1.0, 1.0, 1.0]

    
    
    var endTitle = "Game Complete"
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                flagToAnimate = number
                                flagRotationValues[number] = 360.0
                                flagScaleValues[number] = 1.1
                                for (index, _) in flagOpacityValues.enumerated() {
                                    if index != number {
                                        flagOpacityValues[index] = 0.25
                                        flagScaleValues[index] = 0.95
                                    }
                                }
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(image: countries[number])
                                
//                            .scaleEffect(flagToAnimate == number ? 1.3 : 1.0)
                            .opacity(flagOpacityValues[number])
                            .rotation3DEffect(.degrees(flagRotationValues[number]), axis: (x: 0, y: 1, z: 0))
                            .scaleEffect(flagScaleValues[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.weight(.bold))
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(endTitle, isPresented: $showingEnd) {
            Button("Continue", action: reset)
        } message: {
            Text("Done! Your score is \(score). Restart game?")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that was \(countries[number])"
            score -= 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if questionNumber < maxQuestions {
                showingScore = true
            } else {
                showingEnd = true
            }
        }
    }
    
    func reset() {
        score = 0
        questionNumber = 0
        askQuestion()
    }
    
    func askQuestion() {
        flagToAnimate = -1
        flagRotationValues = [0.0, 0.0, 0.0]
        flagOpacityValues = [1.0, 1.0, 1.0]
        flagScaleValues = [1.0, 1.0, 1.0]
        questionNumber += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
