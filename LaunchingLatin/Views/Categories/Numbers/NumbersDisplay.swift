//
//  NumbersDisplay.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/13/22.
//

import SwiftUI

struct NumbersDisplay: View {
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
                    Text("Numbers")
                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                        .position(x: UIScreen.main.bounds.width/2, y: -15)
                }
                VStack {
                    NavigationLink("Flashcards") {
                        NumbersFlashcards()
                    }
                    NavigationLink("Matching") {
                        NumbersMatching()
                    }
                    NavigationLink("Quiz") {
                        NumbersQuiz()
                    }
                }
                .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                .position(x: UIScreen.main.bounds.width/2, y: -75)
            }
        }
    }
}

struct NumbersDisplay_Previews: PreviewProvider {
    static var previews: some View {
        NumbersDisplay()
            .environmentObject(ModelData())
    }
}
