import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var isFaceUp = false
    var isMatched = false
    var content: String
    var position: CGFloat = 0
}
