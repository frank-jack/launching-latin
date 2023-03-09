//
//  ColorsDisplay.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 7/2/22.
//

import SwiftUI

struct ColorsDisplay: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            VStack {
                ZStack {
                    Image("banner")
                        .resizable()
                        .frame(width: 600, height: 300)
                        .position(x: UIScreen.main.bounds.width/2, y: 0)
                    Text("Colors")
                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                        .position(x: UIScreen.main.bounds.width/2, y: -15)
                }
                VStack {
                    NavigationLink("Flashcards") {
                        ColorsFlashcards()
                    }
                    NavigationLink("Matching") {
                        ColorsMatching()
                    }
                    NavigationLink("Quiz") {
                        ColorsQuiz()
                    }
                }
                .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                .position(x: UIScreen.main.bounds.width/2, y: -75)
            }
        }
    }
}

struct ColorsDisplay_Previews: PreviewProvider {
    static var previews: some View {
        ColorsDisplay()
            .environmentObject(ModelData())
    }
}

