//
//  ColorsFlashcards.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 7/2/22.
//

import SwiftUI

struct ColorsFlashcards: View {
    @EnvironmentObject var modelData: ModelData
    @State private var count = 0
    @State private var showAns = false
    var trueColors = ["black": Color.black, "white": Color.white, "red": Color.red, "orange": Color.orange, "gold": Color.yellow.opacity(0.5), "yellow": Color.yellow, "green": Color.green, "blue": Color.blue, "purple": Color.purple, "pink": Color.pink]
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            VStack {
                if showAns {
                    ZStack {
                        Image("paper")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width*9/4.14, height: UIScreen.main.bounds.height*6/8.96)
                        Text(ModelData().colors[count].latin)
                            .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                    }
                } else {
                    ZStack {
                        Image("paper")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width*9/4.14, height: UIScreen.main.bounds.height*6/8.96)
                        VStack {
                            Text(ModelData().colors[count].english)
                                .foregroundColor(trueColors[ModelData().colors[count].english])
                        }
                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                    }
                }
                HStack {
                    if count != 0 {
                        Button("Go Back") {
                            count-=1
                        }
                    }
                    if ModelData().colors.count-1 > count {
                        Button("Next") {
                            count+=1
                        }
                    }
                }
                if showAns {
                    Button("Show English") {
                        showAns = false
                    }
                } else {
                    Button("Show Latin") {
                        showAns = true
                    }
                }
            }
        }
    }
}

struct ColorsFlashcards_Previews: PreviewProvider {
    static var previews: some View {
        ColorsFlashcards()
            .environmentObject(ModelData())
    }
}

