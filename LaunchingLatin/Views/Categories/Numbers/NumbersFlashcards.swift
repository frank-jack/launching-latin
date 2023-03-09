//
//  NumbersFlashcards.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/13/22.
//

import SwiftUI

struct NumbersFlashcards: View {
    @EnvironmentObject var modelData: ModelData
    @State private var count = 0
    @State private var showAns = false
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            VStack {
                if showAns {
                    ZStack {
                        Image("paper")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width*9/4.14, height: UIScreen.main.bounds.height*6/8.96)
                        Text(ModelData().numbers[count].latin)
                            .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                    }
                } else {
                    ZStack {
                        Image("paper")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width*9/4.14, height: UIScreen.main.bounds.height*6/8.96)
                        VStack {
                            Text(ModelData().numbers[count].number)
                            Text(ModelData().numbers[count].english)
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
                    if ModelData().numbers.count-1 > count {
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

struct NumbersFlashcards_Previews: PreviewProvider {
    static var previews: some View {
        NumbersFlashcards()
            .environmentObject(ModelData())
    }
}
