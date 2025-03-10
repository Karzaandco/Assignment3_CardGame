import SwiftUI

struct ControlPanel: View {
    @ObservedObject var game: CardGameViewModel
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Score: \(game.score)").font(.headline)
                Spacer()
                Text("Moves: \(game.moves)").font(.headline)
            }
            // Centered buttons for New Game and Shuffle
            HStack(spacing: 20) {
                Button("New Game") {
                    withAnimation(.spring()) { game.startNewGame() }
                }
                Button("Shuffle") {
                    withAnimation(.spring()) { game.shuffleCards() }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            if game.gameOver {
                Text("Game Over!")
                    .font(.title)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
