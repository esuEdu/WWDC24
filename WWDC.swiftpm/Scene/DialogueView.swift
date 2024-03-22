//
//  DialogueView.swift
//
//
//  Created by Eduardo on 06/02/24.
//

import SwiftUI

struct DialogueView: View {
    
    @ObservedObject var gameController: GameController
    
    
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var text = ""
    @State private var textHeight: CGFloat = 100
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .opacity(0.01)
                VStack {
                    if orientation.isPortrait {
                        Spacer()
                        HStack {
                            Spacer()
                            Text(text)
                                .padding(.all, 22)
                                .frame(width: geometry.size.width * 0.9)
                                .frame(minWidth: 150)
                                .background {
                                    Rectangle()
                                        .clipShape(
                                            .rect(
                                                topLeadingRadius: 16, topTrailingRadius: 16
                                            )
                                        )
                                }
                            Spacer()
                        }
                    }else if orientation.isLandscape {
                        Spacer()
                        HStack {
                            Spacer()
                            Text(text)
                                .padding(.all, 22)
                                .frame(width: geometry.size.width * 0.9)
                                .frame(minWidth: 150)
                                .background {
                                    Rectangle()
                                        .clipShape(
                                            .rect(
                                                topLeadingRadius: 16, topTrailingRadius: 16
                                            )
                                        )
                                }
                            Spacer()
                        }
                    }
                }
                .ignoresSafeArea()
            }
            .onTapGesture {
                self.gameController.isTextVisible.toggle()
                self.gameController.isMenuVisibility.toggle()
                print(self.gameController.isTextVisible)
            }
            .onRotate { newOrientation in
                orientation = newOrientation
            }
        }
    }
}


#Preview {
    DialogueView(gameController: GameController())
}
