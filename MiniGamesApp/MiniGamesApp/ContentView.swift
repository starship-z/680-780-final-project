import SwiftUI

struct TicTacToe: View {
    var body: some View {
        NavigationView {
            TicTacToeView()
            .navigationTitle("Tic Tac Toe")
        }
    }
}

struct RockPaperScissors: View {
    var body: some View {
        NavigationView {
            RockPaperScissorsView()
            .navigationTitle("Rock Paper Scissors")
        }
    }
}

struct CoinFlip: View {
    var body: some View {
        NavigationView {
            CoinFlipView()
            .navigationTitle("Coin Flipper")
        }
    }
}

struct HomeView: View {
    var body: some View {

        NavigationView {
            ZStack {
                Color.white
                
                VStack{
                    Text("Game Library")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.black)
                        .fontWeight(.black)
                    
                    HStack {
                        VStack {
                            NavigationLink(destination: TicTacToe(), label: {
                                
                                    
                                    
                                    VStack{
                                        Color.blue
                                    }
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(20)
                                
                            })
                            .frame(width: 200, height: 200)
                            .background(.blue)
                            .cornerRadius(20)
                        
                            Text("Tic Tac Toe")
                            .foregroundColor(.black)
                            .fontWeight(.black)
                        }
                        
                        VStack {
                            NavigationLink(destination: RockPaperScissors(), label: {
                                VStack{
                                    Color.pink
                                }
                                .frame(width: 200, height: 200)
                                .cornerRadius(20)
                            })
                            
                            Text("Rock Paper Scissors")
                                .foregroundColor(.black)
                                .fontWeight(.black)
                        }
                        
                    }
                    
                    HStack {
                        VStack {
                            NavigationLink(destination: CoinFlip(), label: {
                        
                        VStack{
                            Color.green
                        }
                        .frame(width: 400, height: 200)
                        .cornerRadius(20)
                        })
                            
                        Text("Coin Flipper")
                                .foregroundColor(.black)
                                .fontWeight(.black)
                        }
                    }
                }
                .offset(y: -60)
            }
            .navigationTitle("Home")
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
