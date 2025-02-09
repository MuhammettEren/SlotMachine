//
//  ContentView.swift
//  SlotMachine
//
//  Created by Muhammet Eren on 8.02.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "High Score")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array = [0,1,2]
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal: Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false

    
    let symbols = ["gfx-bell","gfx-cherry","gfx-coin","gfx-grape","gfx-seven","gfx-strawberry"]
    
    func spinReels(){
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count-1)
            
        })
        
        playSound(sound: "spin", type: "mp3")
    }
    
    func checkWinning(){
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2]{
            playerWins()
            
            if coins > highScore{
                newHighScore()
            } else{
                playSound(sound: "win", type: "mp3")
            }
            
        } else {
            playerLoses()
        }
    }
    
    func playerWins(){
        coins += betAmount * 10
    }
    
    func newHighScore(){
        highScore = coins
        UserDefaults.standard.set(highScore, forKey: "High Score")
        playSound(sound: "high-score", type: "mp3")
    }
    
    func playerLoses(){
        coins -= betAmount
    }
    
    func activeBet20(){
        betAmount = 20
        isActiveBet20.toggle()
        isActiveBet10.toggle()
        playSound(sound: "casion-chips", type: "mp3")
    }
    
    func activeBet10(){
        betAmount = 10
        isActiveBet20.toggle()
        isActiveBet10.toggle()
        playSound(sound: "casion-chips", type: "mp3")
    }
    
    func isGameOver(){
        if coins <= 0 {
            showingModal.toggle()
            playSound(sound: "game-over", type: "mp3")
        }
    }
    
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "High Score")
        highScore = 0
        coins = 100
        activeBet10()
        playSound(sound: "chimeup", type: "mp3")
    }
    
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color("ColorPink"),Color("ColorPurple")], startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 5){
                LogoView()
                    .scaleEffect(0.90)
                
                Spacer()
                
                HStack {
                    HStack{
                        Text("Your\nCoins".uppercased())
                            .foregroundColor(Color.white)
                            .font(.system(size: 10,weight: .bold,design: .rounded))
                            .multilineTextAlignment(.trailing)
                        Text("\(coins)")
                            .foregroundColor(Color.white)
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                            .shadow(color:Color("ColorTransparentBlack"),radius: 0,x: 0,y: 3)
                            .layoutPriority(1)
                    }
                    .padding(.vertical,4)
                    .padding(.horizontal,16)
                    .frame(minWidth: 128)
                    .background(
                        Capsule()
                            .foregroundColor(Color("ColorTransparentBlack"))
                    )
                    
                    Spacer()
                    
                    HStack{
                        Text("\(highScore)")
                            .foregroundColor(Color.white)
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                            .shadow(color:Color("ColorTransparentBlack"),radius: 0,x: 0,y: 3)
                            .layoutPriority(1)
                        
                        Text("Hight\nScore".uppercased())
                            .foregroundColor(Color.white)
                            .font(.system(size: 10,weight: .bold,design: .rounded))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.vertical,4)
                    .padding(.horizontal,16)
                    .frame(minWidth: 128)
                    .background(
                        Capsule()
                            .foregroundColor(Color("ColorTransparentBlack"))
                    )
                    
                }
                
                VStack(alignment: .center, spacing: 0){
                    ZStack{
                        ReelView()
                        
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50 )
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                            .onAppear(perform: {
                                self.animatingSymbol.toggle()
                                playSound(sound: "riseup", type: "mp3")
                            })
                    }
                    
                    HStack(alignment: .center, spacing: 0){
                        ZStack{
                            ReelView()
                            
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50 )
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                    playSound(sound: "riseup", type: "mp3")
                                })
                        }
                        
                        Spacer()
                        
                        ZStack{
                            ReelView()
                            
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50 )
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                    playSound(sound: "riseup", type: "mp3")
                                })
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    
                    Button(action: {
                        withAnimation{
                            self.animatingSymbol = false
                        }
                        
                        self.spinReels()
                        
                        withAnimation{
                            self.animatingSymbol = true
                        }
                        
                        self.checkWinning()
                        
                        self.isGameOver()
                    })  {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    .padding(.bottom,15)
                    
                    HStack {
                        if coins > 10 {
                            HStack(alignment: .center, spacing: 10) {
                                Button(action: {
                                    self.activeBet20()
                                }) {
                                    Text("20")
                                        .fontWeight(.heavy)
                                        .foregroundColor(isActiveBet20 ? Color("ColorYellow") : Color.white)
                                        .modifier(BetNumberModifier())
                                }
                                .modifier(BetCapsuleModifier())
                                
                                Image("gfx-casino-chips")
                                    .resizable()
                                    .opacity(isActiveBet20 ? 1 : 0)
                                    .offset(x: isActiveBet20 ? 0 : 20)
                                    .modifier(CasinoChipsModifier())
                                
                                Spacer()
                            }
                        }
                       
                        
                        HStack(alignment: .center, spacing: 10){
                            
                            Image("gfx-casino-chips")
                                .resizable()
                                .opacity(isActiveBet10 ? 1 : 0)
                                .offset(x:isActiveBet10 ? 0 :-20)
                                .modifier(CasinoChipsModifier())
                            
                            Button(action: {
                                self.activeBet10()
                            })  {
                                Text("10")
                                    .fontWeight(.heavy)
                                    .foregroundColor(isActiveBet10 ? Color("ColorYellow"): Color.white)
                                    .modifier(BetNumberModifier())
                            }
                            .modifier(BetCapsuleModifier())
                            
                            
                            
                        }
                    }
                    
                }
                .layoutPriority(2)
                
                Spacer()
                
                
            }
            .overlay(
                Button(action: {
                    self.resetGame()
                })  {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .font(.title)
                    .foregroundColor(.white),
                alignment: .topLeading
                
            )
            .overlay(
                Button(action: {
                    Text("Info")
                })  {
                    Image(systemName: "info.circle")
                }
                    .font(.title)
                    .foregroundColor(.white),
                alignment: .topTrailing
                
            )
            .padding()
            .frame(maxWidth:720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0,opaque: false)
            
            if $showingModal.wrappedValue{
                ZStack{
                    Color(Color("ColorTransparentBlack")).edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0){
                        Text("Game Over".uppercased())
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 16){
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad luck! You lost all coins. \nLet's play again.")
                                .font(.system(.body,design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                            
                            Button(action: {
                                self.showingModal = false
                                self.animatingModal = false
                                self.activeBet10()
                                self.coins = 100
                            })  {
                                Text("New Game".uppercased())
                                    .font(.system(.body,design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal,12)
                                    .padding(.vertical,8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                                
                            }
                            
                        }
                        
                        Spacer()
                        
                    }
                    .frame(minWidth: 280,idealWidth: 280,maxWidth: 320,minHeight: 260,idealHeight: 280,maxHeight: 320,alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6,x: 0,y: 8)
                    .opacity($animatingModal.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModal.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.6, dampingFraction: 1.60,blendDuration: 1.0))
                    .onAppear(perform: {
                        self.animatingModal = true
                    })
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
