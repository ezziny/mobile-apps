//
//  ShapeSetGame.swift
//  Set game
//
//  Created by ezz on 02/09/2024.
//  this will be the viewmodel
//  bayle.. VILE BAYLE, YOU TOO SHALL KNOW FEAR
import SwiftUI

class ShapeSetGame: ObservableObject {
    @Published private var model: SetGame = SetGame()
    
    //MARK: - data access
    var presentCards : [SetGame.Card]{
        model.presentCards
    }
    var deck : [SetGame.Card]{
        model.deck
    }
    var discardedCards: [SetGame.Card]{
        model.discardedCards
    }
    var isEmptyDeck: Bool{
        model.deck.isEmpty
    }
    
    // MARK: - INTENTS
    
    func selectCard(_ card: SetGame.Card){
        model.selectCard(card)
    }
    
    func draw3Cards(){
        model.draw3Cards()
    }
    
    func startNewGame(){
        model.newGame()
    }
    func shuffle(){
        model.shuffle()
    }
    
}
