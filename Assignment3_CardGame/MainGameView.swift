//
//  DeviceRotationViewModifier.swift
//  Assignment3_CardGame
//
//  Created by Karter Caves on 3/7/25.
//


import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content.onAppear()
               .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    action(UIDevice.current.orientation)
               }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct MainGameView: View {
    @ObservedObject var game = CardGameViewModel()
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    let gridItem = GridItem(.adaptive(minimum: 80))
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.systemTeal).edgesIgnoringSafeArea(.all)
                if orientation.isLandscape {
                    HStack {
                        cardGrid
                        ControlPanel(game: game)
                            .frame(width: geometry.size.width * 0.3)
                    }
                } else {
                    VStack {
                        cardGrid
                        ControlPanel(game: game)
                    }
                }
            }
            .onRotate { newOrientation in
                withAnimation(.spring()) { orientation = newOrientation }
            }
        }
    }
    
    var cardGrid: some View {
        LazyVGrid(columns: [gridItem], spacing: 10) {
            ForEach(game.cards) { card in
                CardView(game: game, card: card)
                    .aspectRatio(0.75, contentMode: .fit)
                    .padding(4)
            }
        }
        .padding()
    }
}
