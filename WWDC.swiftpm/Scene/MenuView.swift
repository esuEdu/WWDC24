//
//  MenuView.swift
//
//
//  Created by Eduardo on 04/02/24.
//

import Foundation
import SwiftUI

struct MenuView: View {
    @ObservedObject var gameController: GameController // Observe GameController
    
    var body: some View {
        ZStack {
            Image("MenuScreen")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            HStack {
                Button(action: {
                    self.gameController.isTextVisible.toggle()
                }) {
                    Text("Play")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                    .onTapGesture {
                        self.gameController.isTextVisible.toggle()
                        print(self.gameController.isMenuVisibility)
                    }
            }
        }
    }
}
