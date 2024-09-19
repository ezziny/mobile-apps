//
//  SetGame.swift
//  Set game
//
//  Created by ezz on 02/09/2024.
//  this shall be the model
import Foundation
struct SetGame {
    struct Card: Identifiable {
        let color: ColorOptions
        let shape: ShapeOptions
        let shading: ShadingOptions
        let numberOfShapes: Int
        var isSelected = false
        var id: Int {
            var hasher = Hasher()
            hasher.combine(color)
            hasher.combine(shape)
            hasher.combine(shading)
            hasher.combine(numberOfShapes)
            return hasher.finalize()
        }
    }

    
    enum ColorOptions: CaseIterable{
        case red, green, blue
    }
    enum ShapeOptions: CaseIterable{
        case rectangle, diamond, oval
    }
    enum ShadingOptions: CaseIterable{
        case full, transparent, empty
    }
    
    private(set) var deck = [Card]()
    private(set) var presentCards = [Card]()
    private(set) var selectedCards = [Card]()
    
    init() {
        newGame()
    }
    
    mutating func initializePresentCards(){
        presentCards = Array(deck.prefix(12))
        deck.removeFirst(12)
    }
    
    mutating func draw3Cards(){
        if deck.count >= 3{
            presentCards.append(contentsOf: deck.prefix(3))
            deck.removeFirst(3)
        }
    }
    
    mutating func newGame(){
        deck.removeAll()
        presentCards.removeAll()
        selectedCards.removeAll()
        
        deck = ColorOptions.allCases.flatMap{color in
            ShapeOptions.allCases.flatMap{shape in
                ShadingOptions.allCases.flatMap{shading in
                    (1...3).map{number in
                        Card(color: color, shape: shape, shading: shading, numberOfShapes: number)
                    }
                }
            }
        }
        deck.shuffle()
        initializePresentCards()
    }
    //logic here is if selected cards < 3 you can select (append to selectedCards) if not check if cards are a valid set through isSet() then handle what happens after  if
    mutating func selectCard(_ card: Card) {
        if let index = presentCards.firstIndex(where: { $0.id == card.id }) {
            var selectedCard = presentCards[index]
            if selectedCards.count < 3 {
                if !selectedCards.contains(where: { $0.id == selectedCard.id }) {
                    selectedCards.append(selectedCard)
                    selectedCard.isSelected.toggle()
                } else {
                    selectedCards.removeAll(where: { $0.id == selectedCard.id })
                    selectedCard.isSelected.toggle()
                }
            }
            presentCards[index] = selectedCard

            if selectedCards.count == 3 {
                if isSet(selectedCards) {
                    handleMatchedCards()
                } else {
                    for selected in selectedCards {
                        if let i = presentCards.firstIndex(where: { $0.id == selected.id }) {
                            presentCards[i].isSelected.toggle()
                        }
                    }
                    selectedCards.removeAll()
                }
            }
        }
    }

    
    mutating func isSet(_ set : [Card] )->Bool{
        guard set.count == 3 else{ return false}
        //the idea behind Sets here is that to form a valid set all instances of attributes have to either be all similar or all different so if it's only red then we cat make a set and if it's red green and blue we can also make a set but if we have red and blue (thus we had red red blue or red blue blue it's not a valid set).
        let colorS = Set(set.map{$0.color})
        let shapeS = Set(set.map{$0.shape})
        let shadingS = Set(set.map{$0.shading})
        let numberS = Set(set.map{$0.numberOfShapes})
        return (colorS.count == 1 || colorS.count == 3) && (shapeS.count == 1 || shapeS.count == 3) && (shadingS.count == 1 || shadingS.count == 3) && (numberS.count == 1 || numberS.count == 3)
    }
    
    mutating func handleMatchedCards(){
        for card in selectedCards{
            if let index = presentCards.firstIndex(where:{$0.id == card.id}){
                presentCards.remove(at: index)
            }
        }
        draw3Cards()
        selectedCards.removeAll()
    }
}
