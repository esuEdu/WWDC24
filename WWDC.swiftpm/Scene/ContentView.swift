//
//  ContentView.swift
//
//
//  Created by Eduardo on 04/02/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var gameController = GameController()
    
    var body: some View {
        ZStack {
            GameOverView()
            ARViewContainer(gameController: self.gameController)
                .opacity(gameController.isARVisible ? 1 : 0)
                .ignoresSafeArea(.all)
            MenuView(gameController: gameController)
                .opacity(gameController.isMenuVisibility ? 1 : 0)
            DialogueView(gameController: self.gameController)
                .opacity(gameController.isTextVisible ? 1 : 0)
        }
    }
}
