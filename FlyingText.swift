//
//  SwiftUIView.swift
//  Set game
//
//  Created by ezz on 29/09/2024.
//

import SwiftUI

struct FlyingText: View {
    let text: String
    let textColor: Color
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        Text(text)
            .font(.system(size: 25))
            .foregroundColor(textColor)
            .shadow(color: .black, radius: 1.5, x: 1, y: 1)
            .offset(x: 0, y: offset)
            .opacity(offset != 0 ? 0 : 1)
            .onAppear {
                withAnimation(.easeIn(duration: 1.5)) {
                    offset = textColor == .red ? 200 : -200
                }
            }
            .onDisappear {
                offset = 0
            }
    }
}

struct FlyingText_Previews: PreviewProvider {
    static var previews: some View {
        FlyingText(text: "Mismatch ❌", textColor: .red)
    }
}
//Too busy/lazy to implement this but hey mr stalker. it's a good addition if you wanna use it.
