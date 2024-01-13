//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Nazar on 12.01.2024.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.black)
    }
}

struct ContentView: View {
    
    @State private var showingWiner = false
    @State private var title = "Rock Paper Scissor"
    @State private var player1Score = 0
    @State private var player2Score = 0
    @State private var turn = 0
    
    
    @State private var rockPaperScissor = ["Rock", "Paper", "Scissor"]
    
    @State private var player1WinScore = 0
    @State private var player2WinScore = 0
    
    @State private var player1Chose = 2
    @State private var player2Chose = 2
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .center)
                        .frame(width: geometry.size.width, height: geometry.size.height / 2 + 10)
                    LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .bottom, endPoint: .center)
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                }
            }
            .ignoresSafeArea()
           
                VStack {
                    
                    Text("\(player1Score)")
                        .foregroundStyle(.white)
                        .font(.system(size: 50).bold())
                
                    Text("Player 1 score")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                  
                    VStack {
                            Button {
                                
                                if turn == 10 {
                                    showingWiner = true
                                   
                                } else {
                                    turn += 1
                                    nextTurn()
                                    rockPaperScissorTaped()
                                }
                                
                            } label: {
                                rockPaperScissorImage(rockPaperScissorFileName: rockPaperScissor[player1Chose])
                            }
                        Text(title)
                            .modifier(Title())
                        
                            Button {
                                
                                if turn == 10 {
                                    showingWiner = true

                                } else {
                                    turn += 1
                                    nextTurn()
                                    rockPaperScissorTaped()
                                }
                              
                            } label: {
                                rockPaperScissorImage(rockPaperScissorFileName: rockPaperScissor[player2Chose])
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding()
                    .padding(.leading)
                    .padding(.trailing)
                    
                    Text("Player 2 score")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                 
                    Text("\(player2Score)")
                        .foregroundStyle(.white)
                        .font(.system(size: 50).bold())
                }
            }
            .alert("Player \( player1Score >  player2Score ? 1 : 2) WIN!", isPresented: $showingWiner) {
                Button("Restart Game", action: restartGame)
            } message: {
                Text("P1:  \( player1Score) & P2:  \( player2Score))")
            }
        
        
    }

func rockPaperScissorImage(rockPaperScissorFileName: String) -> some View {
    return Image(rockPaperScissorFileName)
        .renderingMode(.original)
        .resizable() // make the image resizable
        .frame(width: 250, height: 230) // set the image view size to 100x100
        .aspectRatio(contentMode: .fit) // scale the image to fit the frame
        .shadow(radius: 20)
}

    func rockPaperScissorTaped() {
        if player1Chose == player2Chose {
            title = "Turn \(turn):   " + "Draw!"
            player1Score += 1
            player2Score += 1
        } else if player1Chose == 0 && player2Chose == 1 {
            title = "Turn \(turn):   " + "Player 2 WIN!"
            player1Score += 3
            player2Score -= 3
        } else if player1Chose == 0 && player2Chose == 2 {
            title = "Turn \(turn):   " + "Player 1 WIN!"
            player1Score -= 3
            player2Score += 3
        } else if player1Chose == 1 && player2Chose == 0 {
            title = "Turn \(turn):    " + "Player 1 WIN!"
            player1Score += 3
            player2Score -= 3
        } else if player1Chose == 1 && player2Chose == 2 {
            title = "Turn \(turn):   " + "Player 2 WIN!"
            player1Score -= 3
            player2Score += 3
        } else if player1Chose == 2 && player2Chose == 0 {
            title = "Turn \(turn):   " + "Player 2 WIN!"
            player1Score -= 3
            player2Score += 3
        } else if player1Chose == 2 && player2Chose == 1 {
            title = "Turn \(turn):   " + "Player 1 WIN!"
            player1Score += 3
            player2Score -= 3
        }
    }
    
    func nextTurn() {
        player1Chose = Int.random(in: 0...2)
        player2Chose = Int.random(in: 0...2)
    }
    
    func restartGame() {
        
        player1Score = 0
        player2Score = 0
        player1Chose = 2
        player2Chose = 2
        turn = 0
        title = "Rock Paper Scissor"
        
    }
}

#Preview {
    ContentView()
}
