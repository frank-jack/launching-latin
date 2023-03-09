//
//  NaturalsDisplay.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 7/4/22.
//

import SwiftUI

struct NaturalsDisplay: View {
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
                    Text("Nature")
                        .font(.custom("Palatino-Roman", fixedSize: 26).weight(.black))
                        .position(x: UIScreen.main.bounds.width/2, y: -15)
                }
                VStack {
                    NavigationLink("Flashcards") {
                        NaturalsFlashcards()
                    }
                    NavigationLink("Matching") {
                        NaturalsMatching()
                    }
                    NavigationLink("Quiz") {
                        NaturalsQuiz()
                    }
                }
                .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                .position(x: UIScreen.main.bounds.width/2, y: -75)
            }
        }
    }
}

struct NaturalsDisplay_Previews: PreviewProvider {
    static var previews: some View {
        NaturalsDisplay()
            .environmentObject(ModelData())
    }
}

