import SwiftUI

// TIC TAC TOE - Made by Robert Cacho
// Attribution - Jared Davidson
enum SquareStatus{
    case empty
    case home
    case visitor
}

class Square : ObservableObject{
    @Published var squareStatus : SquareStatus
    
    init(status : SquareStatus){
        self.squareStatus = status
    }
}

class TicTacToeModel : ObservableObject{
    @Published var squares = [Square]()
    
    init(){
        for _ in 0...8{
            squares.append(Square(status: .empty))
        }
    }
    
    func resetGame(){
        // set each square to .empty to clear
        for i in 0...8{
            squares[i].squareStatus = .empty
        }
    }
    
    var gameOver : (SquareStatus, Bool){
        get {
            
            if isWinner != .empty{
                return (isWinner, true)
            }else{
                for i in 0...8{
                    if squares[i].squareStatus == .empty{
                        return(.empty, false)
                    }
                }
                return(.empty, true)
            }
        }
    }
    
    private var isWinner: SquareStatus {
        get {
            if let check = self.checkIndexes([0, 1, 2]){
                return check
            }else if let check = self.checkIndexes([3, 4, 5]){
                return check
            }else if let check = self.checkIndexes([6, 7, 8]){
                return check
            }else if let check = self.checkIndexes([0, 3, 6]){
                return check
            }else if let check = self.checkIndexes([1, 4, 7]){
                return check
            }else if let check = self.checkIndexes([2, 5, 8]){
                return check
            }else if let check = self.checkIndexes([0, 4, 8]){
                return check
            }else if let check = self.checkIndexes([2, 4, 6]){
                return check
            }
            return .empty
        }
    }
    
    private func checkIndexes(_ indexes : [Int]) -> SquareStatus?{
        var homeCounter : Int = 0
        var visitorCounter : Int = 0
        for index in indexes{
            let square = squares[index]
            if square.squareStatus == .home{
                homeCounter += 1
            }else if square.squareStatus == .visitor{
                visitorCounter += 1
            }
        }
        if homeCounter == 3{
            return .home
        }else if visitorCounter == 3{
            return .visitor
        }
        return nil
    }
    
    private func moveAI(){
        var index = Int.random(in: 0...8)
        while makeMove(index: index, player: .visitor) == false && gameOver.1 == false{
            index = Int.random(in: 0...8)
        }
    }
    
    func makeMove(index: Int, player: SquareStatus) -> Bool{
        if squares[index].squareStatus == .empty{
            squares[index].squareStatus = player
            if player == .home{
                moveAI()
            }
            return true
        }
        return false
    }
}

struct SquareView : View {
    @ObservedObject var dataSource : Square
    var action: () -> Void
    var body: some View{
        Button(action: {
            self.action()
        }, label: {
            Text(self.dataSource.squareStatus == .home ? "X" : self.dataSource.squareStatus == .visitor ? "O" : " " )
                .frame(width: 100, height: 100)
                .font(.largeTitle)
                
                .foregroundColor(.black)
                .background(Color.gray.opacity(0.3).cornerRadius(10))
                .padding(4)
        }).frame(width: 100, height: 100)
    }
}

struct TicTacToeView: View {
    @StateObject var tttModel = TicTacToeModel()
    @State var gameOver : Bool = false
    
    func buttonAction(_ index : Int){
        _ = self.tttModel.makeMove(index: index, player: .home)
        self.gameOver = self.tttModel.gameOver.1
    }
    
    var body: some View {
        VStack{
            ForEach(0..<3, content: {
                row in
                HStack{
                    ForEach(0..<3, content: {
                        column in
                        let index = row * 3 + column
                        SquareView(dataSource: tttModel.squares[index], action: {self.buttonAction(index)})
                    })
                }
            })
        }.alert(isPresented: self.$gameOver, content: {
            Alert(title: Text("Game Over"), message: Text(self.tttModel.gameOver.0 != .empty ? self.tttModel.gameOver.0 == .home ? "You Win" : "Computer Wins" : "Cat's Game"), dismissButton: Alert.Button.destructive(Text("OK"), action: {
                self.tttModel.resetGame()
            }))
        })
    }
}

struct TicTacToe_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToe()
    }
}
