import SwiftUI

struct CoinFlipView : View {
    @State var isFlipping = false
    @State var isHeads = false
    @State var degreesToFlip: Int = 0
    @State var tailsCount: Int = 0
    @State var headsCount: Int = 0
    
    var body : some View {
        VStack{
            VStack{
                Text("Heads: \(headsCount)")
                Text("Tails: \(tailsCount)")
            }
            Spacer()
            Coin(isFlipping: $isFlipping, isHeads: $isHeads)
                .rotation3DEffect(Angle(degrees: Double(degreesToFlip)), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
            Spacer()
            Button("Flip"){
                flipCoin()
            }
        }
    }
    
    func flipCoin(){
        withAnimation{
            let random = Int.random(in: 5...6)
            if degreesToFlip > 1800000000{
                resetGame()
            }
            degreesToFlip += (random * 180)
            headOrTail()
            isFlipping.toggle()
        }
    }

    func headOrTail(){
        let divisible = degreesToFlip / 180
        (divisible % 2) == 0 ? (isHeads = false) : (isHeads = true)
        isHeads == true ? (headsCount += 1) : (tailsCount += 1)
    }

    func resetGame(){
        degreesToFlip = 0
    }
}

struct Coin : View {
    @Binding var isFlipping: Bool
    @Binding var isHeads: Bool
    
    var body : some View {
        ZStack{
            Circle()
                .foregroundColor(isHeads ? .gray : .orange)
                .frame(width: 110, height: 110)
            Circle()
                .foregroundColor(isHeads ? .green : .yellow)
                .frame(width: 100, height: 100)
        }
    }
}

struct CoinFlip_Previews: PreviewProvider {
    static var previews: some View {
        CoinFlip()
    }
}
