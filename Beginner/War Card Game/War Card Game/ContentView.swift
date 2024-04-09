//
//  ContentView.swift
//  War Card Game
//
//  Created by Gergő on 07/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var playerNum:Int = 0
    @State var cpuNum:Int = 0
    
    @State var playerCard:String = "card3"
    @State var cpuCard:String = "card13"
    
    @State var playerScore:Int = 0
    @State var cpuScore:Int = 0
    
    var body: some View {
        ZStack {
            Image("background-plain")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                Spacer()
                Button(action: {
                    deal()
                }, label: {
                    Image("button")
                })
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Text("Player")
                            .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 10.0)
                            
                        Text(String(playerScore))
                            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 10.0)
                        Text(String(cpuScore))
                            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    func deal(){
        //Randomize player and cpu cards
        playerNum = Int.random(in: 2...13)
        playerCard = "card" + String(playerNum)
        
        cpuNum = Int.random(in: 2...13)
        cpuCard = "card" + String(cpuNum)
        
        if playerNum > cpuNum {
            playerScore += 1
        }
        else if cpuNum > playerNum {
            cpuScore += 1
        }
    }
}

#Preview {
    ContentView()
}
