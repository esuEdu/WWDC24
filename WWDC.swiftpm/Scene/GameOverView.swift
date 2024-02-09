//
//  SwiftUIView.swift
//  
//
//  Created by Eduardo on 07/02/24.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding()
                
                Button(action: {
                    // Reset the game or navigate to another screen
                }) {
                    Text("Play Again")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    GameOverView()
}
