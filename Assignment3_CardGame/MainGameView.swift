import SwiftUI

struct MainGameView: View {
    @ObservedObject var game = CardGameViewModel()
    
    // 4 columns for a 3x4 grid (12 cards)
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            // Extends the background color to cover the entire screen
            Color(red: 0.9, green: 0.95, blue: 1.0)
                .ignoresSafeArea()
            
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(game.cards) { card in
                        CardView(game: game, card: card)
                            .aspectRatio(0.75, contentMode: .fit)
                    }
                }
                .padding()
                
                ControlPanel(game: game)
                    .padding()
            }
        }
    }
}
