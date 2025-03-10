//
//  CardView.swift
//  Assignment3_CardGame
//
//  Created by Karter Caves on 3/10/25.
//


import SwiftUI

struct CardView: View {
    @ObservedObject var game: CardGameViewModel
    let card: Card
    @State private var dragAmount: CGSize = .zero

    var body: some View {
        ZStack {
            CardFront(card: card).opacity(card.isFaceUp ? 1 : 0)
            CardBack(card: card).opacity(card.isFaceUp ? 0 : 1)
        }
        .frame(width: 80, height: 120)
        .rotation3DEffect(Angle(degrees: card.isFaceUp ? 0 : 180),
                          axis: (x: 0, y: 1, z: 0))
        .offset(dragAmount)
        .gesture(
            DragGesture()
                .onChanged { value in dragAmount = value.translation }
                .onEnded { _ in dragAmount = .zero }
        )
        .onTapGesture {
            withAnimation {
                game.selectCard(card: card)
            }
        }
    }
}

struct CardFront: View {
    let card: Card
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .overlay(Text(card.content).font(.largeTitle))
            .shadow(radius: 5)
    }
}

struct CardBack: View {
    let card: Card
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .overlay(Text("★").font(.largeTitle).foregroundColor(.white))
            .shadow(radius: 5)
    }
}
