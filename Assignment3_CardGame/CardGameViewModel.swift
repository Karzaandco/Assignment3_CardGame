import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var score: Int = 0
    @Published var moves: Int = 0
    @Published var gameOver: Bool = false
    
    private var firstSelectedCard: Card?

    init() {
        startNewGame()
    }
    
    func startNewGame() {
        let emojis = ["😀", "😎", "🥳", "🤓"]
        var newCards: [Card] = []
        for emoji in emojis {
            newCards.append(Card(content: emoji))
            newCards.append(Card(content: emoji))
        }
        cards = newCards.shuffled()
        score = 0
        moves = 0
        gameOver = false
        firstSelectedCard = nil
    }
    
    func shuffleCards() {
        cards.shuffle()
    }
    
    func selectCard(card: Card) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isFaceUp,
              !cards[index].isMatched else { return }
        
        if let firstCard = firstSelectedCard,
           let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }) {
            moves += 1
            cards[index].isFaceUp = true
            
            if cards[index].content == cards[firstIndex].content {
                cards[index].isMatched = true
                cards[firstIndex].isMatched = true
                score += 2
                if cards.allSatisfy({ $0.isMatched }) { gameOver = true }
            } else {
                if score > 0 { score -= 1 }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.cards[index].isFaceUp = false
                    self.cards[firstIndex].isFaceUp = false
                }
            }
            firstSelectedCard = nil
        } else {
            for idx in cards.indices where !cards[idx].isMatched {
                cards[idx].isFaceUp = false
            }
            firstSelectedCard = cards[index]
            cards[index].isFaceUp = true
        }
    }
}
