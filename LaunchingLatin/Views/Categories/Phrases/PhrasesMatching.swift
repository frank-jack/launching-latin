//
//  PhrasesMatching.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 7/5/22.
//

import SwiftUI
import ConfettiSwiftUI

struct PhrasesMatching: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    @State private var begun = false
    @State private var orderLatin: [Int] = []
    @State private var orderEnglish: [Int] = []
    @State private var temp = 0
    @State private var latinChoice = -1
    @State private var englishChoice = -2
    @State private var text = ""
    @State private var imageNumberLatin = -1
    @State private var imageNumberEnglish = -1
    @State private var matchesCorrect = 0
    @State private var matchesWrong = 0
    @State private var latinCorrect: [Int] = []
    @State private var englishCorrect: [Int] = []
    @State private var latinWrong: [Int] = []
    @State private var englishWrong: [Int] = []
    @State private var collected = false
    @State private var oldCoinAmount = 0
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            if begun {
                VStack {
                    if (matchesCorrect+matchesWrong) < ModelData().phrases.count {
                        Button("Submit Match") {
                            if latinChoice<0 || englishChoice<0 {
                                text = "You haven't made a full selection..."
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    text = ""
                                }
                            }
                            if latinChoice == englishChoice {
                                matchesCorrect+=1
                                SoundManager.instance.playSound(sound: .yes)
                                text = "Correct Match!"
                                latinCorrect.append(orderLatin.firstIndex(of: latinChoice)!)
                                englishCorrect.append(orderEnglish.firstIndex(of: englishChoice)!)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    text = ""
                                }
                            } else {
                                matchesWrong+=1
                                SoundManager.instance.playSound(sound: .no)
                                text = "That's not right..."
                                latinWrong.append(orderLatin.firstIndex(of: latinChoice)!)
                                englishWrong.append(orderEnglish.firstIndex(of: englishChoice)!)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    text = ""
                                }
                            }
                            latinChoice = -1
                            englishChoice = -2
                        }
                        .confettiCannon(counter: $matchesCorrect)
                        Text(text)
                        HStack {
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack {
                                    ForEach(orderLatin, id: \.self) { i in
                                        ZStack {
                                            if imageNumberLatin == i {
                                                Image("yellow")
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width/4.14, height: UIScreen.main.bounds.height*2/8.96)
                                            }
                                            if latinCorrect.contains(i) {
                                                Image("green")
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width/4.14, height: UIScreen.main.bounds.height*2/8.96)
                                            }
                                            if latinWrong.contains(i) {
                                                Image("red")
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width/4.14, height: UIScreen.main.bounds.height*2/8.96)
                                            }
                                            Image("paper")
                                                .resizable()
                                                .frame(width: UIScreen.main.bounds.width*3/4.14, height: UIScreen.main.bounds.height*2/8.96)
                                            Button(ModelData().phrases[orderLatin[i]].latin) {
                                                latinChoice = orderLatin[i]
                                                imageNumberLatin = i
                                            }
                                        }
                                    }
                                }
                            }
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack {
                                    ForEach(orderEnglish, id: \.self) { i in
                                        ZStack {
                                            if imageNumberEnglish == i {
                                                Image("yellow")
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width/4.14, height: UIScreen.main.bounds.height*2/8.96)
                                            }
                                            if englishCorrect.contains(i) {
                                                Image("green")
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width/4.14, height: UIScreen.main.bounds.height*2/8.96)
                                            }
                                            if englishWrong.contains(i) {
                                                Image("red")
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width/4.14, height: UIScreen.main.bounds.height*2/8.96)
                                            }
                                            Image("paper")
                                                .resizable()
                                                .frame(width: UIScreen.main.bounds.width*3/4.14, height: UIScreen.main.bounds.height*2/8.96)
                                            Button(ModelData().phrases[orderEnglish[i]].english) {
                                                englishChoice = orderEnglish[i]
                                                imageNumberEnglish = i
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    } else {
                        VStack {
                            Text("Your Score was "+String(matchesCorrect)+"/"+String(ModelData().phrases.count))
                                .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                            HStack {
                                Text("You get "+String(matchesCorrect*10))
                                    .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                ZStack {
                                    Image("coin")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    if !collected {
                                        Image("coin")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .transition(.offset(x: -UIScreen.main.bounds.width, y: UIScreen.main.bounds.height))
                                    }
                                }
                            }
                            if !collected && matchesCorrect>0 {
                                Button("Collect Coins") {
                                    withAnimation {
                                        collected = true
                                    }
                                    modelData.profile.coinAmount = oldCoinAmount+(matchesCorrect*10)
                                    let params = ["userId": modelData.profile.userId, "coinAmount": String(modelData.profile.coinAmount), "storage": modelData.profile.storage.description] as! Dictionary<String, String>
                                    var request = URLRequest(url: URL(string: "https://7snhsr8dgc.execute-api.us-east-1.amazonaws.com/dev/userdata")!)
                                    request.httpMethod = "PUT"
                                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                                    let session = URLSession.shared
                                    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                                        print(response!)
                                        do {
                                            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                                            print(json)
                                        } catch {
                                            print("error")
                                        }
                                    })
                                    task.resume()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                Button("Begin Matching!") {
                    while orderLatin.count<ModelData().phrases.count {
                        temp=Int.random(in: 0...ModelData().phrases.count-1)
                        if !orderLatin.contains(temp) {
                            orderLatin.append(temp)
                        }
                    }
                    while orderEnglish.count<ModelData().phrases.count {
                        temp=Int.random(in: 0...ModelData().phrases.count-1)
                        if !orderEnglish.contains(temp) {
                            orderEnglish.append(temp)
                        }
                    }
                    oldCoinAmount = modelData.profile.coinAmount
                    begun = true
                }
                .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
            }
        }
    }
}

struct PhrasesMatching_Previews: PreviewProvider {
    static var previews: some View {
        PhrasesMatching()
            .environmentObject(ModelData())
    }
}
