//
//  Card.swift
//  Assignment3_CardGame
//
//  Created by Karter Caves on 3/10/25.
//


import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var isFaceUp = false
    var isMatched = false
    var content: String
    var position: CGFloat = 0
}
