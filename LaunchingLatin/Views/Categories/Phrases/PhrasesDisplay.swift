//
//  PhrasesDisplay.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 7/5/22.
//

import SwiftUI

struct PhrasesDisplay: View {
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
                    Text("Phrases")
                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                        .position(x: UIScreen.main.bounds.width/2, y: -15)
                }
                VStack {
                    NavigationLink("Flashcards") {
                        PhrasesFlashcards()
                    }
                    NavigationLink("Matching") {
                        PhrasesMatching()
                    }
                    NavigationLink("Quiz") {
                        PhrasesQuiz()
                    }
                }
                .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                .position(x: UIScreen.main.bounds.width/2, y: -75)
            }
        }
    }
}

struct PhrasesDisplay_Previews: PreviewProvider {
    static var previews: some View {
        PhrasesDisplay()
            .environmentObject(ModelData())
    }
}
