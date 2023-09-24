//
//  ContentView.swift
//  HelloWatch Watch App
//
//  Created by Eliseu Codinhoto on 17/09/23.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["🎃", "👻", "💀", "😈", "☠️", "👽"]
    
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))], content: {
            ForEach(0..<cardCount, id: \.self) {
                index in CardView(content: emojis[index]).aspectRatio(contentMode: .fit)
            }
        }).foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
            Spacer()
            cardAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
        }
    }
    
    func cardAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {cardCount += offset}, label: {
            Image(systemName: symbol)
        }).disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
}

struct CardView: View {
    let content : String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.title2)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
