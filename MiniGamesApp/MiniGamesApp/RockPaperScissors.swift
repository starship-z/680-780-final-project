import SwiftUI

// ROCK PAPER SCISSORS - Made by Ana Nytochka
// Attribution - Citrus Apps
struct RockPaperScissorsView: View {
    
    let options = ["Rock", "Paper", "Scissors"]
    
    @State private var computer = Int.random(in: 0..<3)
    @State private var win = Bool.random()
    @State private var playerScore = 0
    @State private var currentStep = 1
    @State private var showingAlert = false
    
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25){
                Text("Steps: \(currentStep)/10")
                    .font(.title)
                Text("Player score: \(playerScore)")
                    .font(.title)
                Text(options[computer])
                    .font(.largeTitle)
                Text(win ? "Win" : "Lose")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack(spacing: 8){
                    ForEach(0 ..< 3){ optionID in
                        Button(action: {
                            if self.currentStep == 10 {
                                self.currentStep = 0
                                self.playerScore = 0
                                self.showingAlert = true
                            }else{
                                self.calculateScore(withMove: optionID)
                            }
                        }){
                            Text("\(self.options[optionID])")
                                .foregroundColor(.white)
                        }
                        .frame(width: 100, height: 100, alignment: .center)
                        .background(Color.purple)
                        .clipShape(Capsule())
                        
                        .alert(isPresented: self.$showingAlert){
                            Alert(title: Text("Game Over"), message: Text("Final Score: \(playerScore)"), dismissButton: .default(Text("OK")))
                        }
                    }
                }
            }
            .foregroundColor(.black)
        }
    }
    func calculateScore(withMove currentPlayerChoice: Int){
        if computer == currentPlayerChoice{
            playerScore += 0
        }else if win{
            switch computer{
            case 0:
                if currentPlayerChoice == 1{
                    playerScore += 1
                }
            case 1:
                if currentPlayerChoice == 2{
                    playerScore += 1
                }
            case 2:
                if currentPlayerChoice == 0{
                    playerScore += 1
                }
            default:
                break
            }
        }else{
            switch computer{
            case 0:
                if currentPlayerChoice == 2{
                    playerScore += 1
                }
            case 1:
                if currentPlayerChoice == 0{
                    playerScore += 1
                }
            case 2:
                if currentPlayerChoice == 1{
                    playerScore += 1
                }
            default:
                break
            }
        }
        computer = Int.random(in: 0 ..< 3)
        win = Bool.random()
        currentStep += 1
    }
}

struct RockPaperScissors_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperScissors()
    }
}
