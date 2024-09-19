//
//  SetGameView.swift
//  Set game
//
//  Created by ezz on 02/09/2024.
//
import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel = ShapeSetGame()
    
    var body: some View {
        VStack {
            AspectVGrid(viewModel.presentCards, aspectRatio: 2/3) { card in
                CardView(card: card, isSelected: card.isSelected)
                    .onTapGesture {
                        viewModel.selectCard(card)
                    }
                    .padding(5)
            }
            .padding()

            HStack {
                Button("Deal 3 More Cards") {
                    viewModel.draw3Cards()
                }
                .disabled(viewModel.isEmptyDeck) // Disable when deck is empty
                
                Button("New Game") {
                    viewModel.startNewGame()
                }
            }
            .padding()
        }
    }
}
import SwiftUI

struct CardView: View {
    var card: SetGame.Card
    var isSelected : Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(Color.white)
            RoundedRectangle(cornerRadius: 10).stroke(isSelected ? Color.blue : Color.black ,lineWidth: 3)
            
            VStack {
                ForEach(0..<card.numberOfShapes, id: \.self) { _ in
                    shapeFor(card)
                        .aspectRatio(2, contentMode: .fit)
                }
            }
            .padding()
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    // Shape rendering based on card type
    @ViewBuilder
    func shapeFor(_ card: SetGame.Card) -> some View {
        let colorr = Color(colorFor(card))
        let opacity = opacityFor(card)
        switch card.shape {
        case .rectangle:
            Rectangle().stroke(colorr,lineWidth: 5).fill(.white).overlay(Rectangle().stroke(colorr).fill(colorr).opacity(opacity))
        case .oval:
            Capsule().stroke(colorr,lineWidth: 5).fill(.white).overlay(Capsule().stroke(colorr).fill(colorr).opacity(opacity))
        case .diamond:
            Diamond().stroke(colorr,lineWidth: 5).fill(.white).overlay(Diamond().stroke(colorr).fill(colorr).opacity(opacity))
        }
    }
    
    // Color rendering based on card type
    func colorFor(_ card: SetGame.Card) -> Color {
        switch card.color {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }
    
    // Opacity based on shading
    func opacityFor(_ card: SetGame.Card) -> Double {
        switch card.shading {
        case .full:
            return 1.0
        case .transparent:
            return 0.5
        case .empty:
            return 0
        }
    }
}

// Custom diamond shape
struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))  // Top point
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))  // Right point
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))  // Bottom point
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))  // Left point
        path.closeSubpath()
        return path
    }
}





#Preview {
    SetGameView()
}
