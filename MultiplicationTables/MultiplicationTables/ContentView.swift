//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Joey Rideout on 2023-06-16.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settingsPage: Bool
    @Binding var multiplicationTablesLimit: Int
    @Binding var numQuestions: Int
    @Binding var questions: [(Int, Int)]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Text("Multiplication table limit:")
                        Stepper("Up to \(multiplicationTablesLimit) x \(multiplicationTablesLimit)", value: $multiplicationTablesLimit, in: 2...12, onEditingChanged: { _ in
                            questions = generateQuestions(multiplicationTablesLimit)
                            }
                        )
                    }
                    
                    Section {
                        Text("Number of questions:")
                        Stepper("\(numQuestions)", value: $numQuestions, in: 5...20, step: 5)
                    }
                }
                Button("Begin") {
                    settingsPage = false
                }
                .font(.title)
            }
            .navigationTitle("Configure Game")
                
        }
    }
}

struct GameView: View {
    @Binding var currentQuestion: Int
    @Binding var score: Int
    @Binding var numQuestions: Int
    @Binding var questions: [(Int, Int)]
    @Binding var multiplicationTablesLimit: Int
    @Binding var answer: Int
    @Binding var alertTitle: String
    @Binding var alertShowing: Bool
    @Binding var endShowing: Bool
    
    var body: some View {
        VStack {
            Text("\(questions[currentQuestion].0) x \(questions[currentQuestion].1)")
            Form {
                TextField("Answer", value: $answer, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                Button("Submit") {
                    if questions[currentQuestion].0 * questions[currentQuestion].1 == answer {
                        alertTitle = "Correct!"
                        score += 1
                    } else {
                        alertTitle = "Wrong!"
                    }
                    alertShowing = true
                }
            }
        }
    }
}

func generateQuestions(_ limit: Int) -> [(Int, Int)] {
    var questions = [(Int, Int)]()
    for _ in 1...20 {
        questions.append((Int.random(in: 1...limit), Int.random(in: 1...limit)))
    }
    return questions
}

struct ContentView: View {
    @State var settingsPage = true
    @State var multiplicationTablesLimit = 9
    @State var numQuestions = 5
    @State var currentQuestion = 0
    @State var answer = 0
    @State var score = 0
    @State var questions = generateQuestions(9)
    @State var alertTitle = ""
    @State var alertShowing = false
    @State var endShowing = false
    var endTitle: String {
        return "Game over! Your score is \(score)/\(numQuestions)."
    }
    
    var body: some View {
        if settingsPage {
            SettingsView(settingsPage: $settingsPage, multiplicationTablesLimit: $multiplicationTablesLimit, numQuestions: $numQuestions, questions: $questions)
        } else {
            GameView(currentQuestion: $currentQuestion, score: $score, numQuestions: $numQuestions, questions: $questions, multiplicationTablesLimit: $multiplicationTablesLimit, answer: $answer, alertTitle: $alertTitle, alertShowing: $alertShowing, endShowing: $endShowing)
                .alert(alertTitle, isPresented: $alertShowing) {
                    Button("Next") {
                        if currentQuestion < numQuestions - 1 {
                            currentQuestion += 1
                        } else {
                            endShowing = true
                            currentQuestion = 0
                            questions = generateQuestions(multiplicationTablesLimit)
                            currentQuestion = 0
                        }
                    }
                }
                .alert(endTitle, isPresented: $endShowing) {
                    Button("Retry") {
                        score = 0
                    }
                    Button("Configure Settings") {
                        settingsPage = true
                        score = 0
                    }
                }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
