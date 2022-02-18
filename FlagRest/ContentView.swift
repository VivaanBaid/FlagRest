//
//  ContentView.swift
//  FlagRest
//
//  Created by Vivaan Baid on 17/02/22.
//

import SwiftUI

struct ContentView: View {
    
    //Country Array
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    //Random country Generator
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var run = 0
    
    //Alert state tracker
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var ShowingRestartPrompt = false
    @State private var answerChosen = 0
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [Color.blue,Color.black], center: .center, startRadius: 45, endRadius: 355)
                .ignoresSafeArea()
            VStack{
                Text("Guess the Flag")
                       .font(.largeTitle.weight(.bold))
                       .foregroundColor(.white)
                Spacer()
                Text("Your score \(score)")
                    .foregroundColor(Color.white)
                Spacer()
                VStack(spacing: 30){
                    VStack {
                        Text("Tap the flag of")
                        Text(countries[correctAnswer])
                    }
                    .foregroundColor(Color.white)
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                            answerChosen = number
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            
        }
        .alert("Game Over", isPresented: $ShowingRestartPrompt) {
            Button("Restart", action: resetGame)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(scoreTitle) this is \(countries[answerChosen])")
            Text("Your score is \(score)")
        }
        
    }
    
    func flagTapped(_ number: Int) {
      if(run < 9){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score+=1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
        run += 1
        }
        else{
            ShowingRestartPrompt = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame(){
        score = 0
        askQuestion()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
