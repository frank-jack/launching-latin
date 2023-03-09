//
//  ColorsQuiz.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 7/2/22.
//

import SwiftUI
import ConfettiSwiftUI

struct ColorsQuiz: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    @State private var begun = false
    @State private var finished = false
    @State private var collected = false
    @State private var latinToEnglish = false
    @State private var questionsRight = 0
    @State private var oldCoinAmount = 0
    @State private var answered = false
    @State private var correct = false
    @State private var answer = ""
    @State private var order:[Int] = []
    @State private var temp = 0
    var trueColors = ["black": Color.black, "white": Color.white, "red": Color.red, "orange": Color.orange, "gold": Color.yellow.opacity(0.5), "yellow": Color.yellow, "green": Color.green, "blue": Color.blue, "purple": Color.purple, "pink": Color.pink]
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            if finished {
                VStack {
                    Text("Your Score was "+String(questionsRight)+"/"+String(ModelData().colors.count))
                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                    HStack {
                        Text("You get "+String(questionsRight*10))
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
                    if !collected && questionsRight>0 {
                        Button("Collect Coins") {
                            withAnimation {
                                collected = true
                            }
                            modelData.profile.coinAmount = oldCoinAmount+(questionsRight*10)
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
            } else {
                if begun {
                    if !answered {
                        if latinToEnglish {
                            VStack {
                                ZStack {
                                    Image("paper")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width*9/4.14, height: UIScreen.main.bounds.height*6/8.96)
                                    VStack {
                                        Text("What is the\nEnglish for")
                                            .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                        Text(ModelData().colors[temp].latin+"?")
                                            .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                    }
                                }
                                TextField("Answer", text: $answer)
                                    .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                    .padding(.horizontal)
                                Button("Submit") {
                                    if (answer.caseInsensitiveCompare(ModelData().colors[temp].english) == .orderedSame) {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            answered = true
                                        }
                                        correct = true
                                        questionsRight+=1
                                        SoundManager.instance.playSound(sound: .yes)
                                    } else {
                                        answered = true
                                        correct = false
                                        SoundManager.instance.playSound(sound: .no)
                                    }
                                }
                                .confettiCannon(counter: $questionsRight)
                            }
                            .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height*2.5/8.96)
                        } else {
                            VStack {
                                ZStack {
                                    Image("paper")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width*9/4.14, height: UIScreen.main.bounds.height*6/8.96)
                                    VStack {
                                        Text("What is the\nLatin for")
                                            .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                        Text(ModelData().colors[temp].english+"?")
                                            .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                    }
                                    .foregroundColor(trueColors[ModelData().colors[temp].english])
                                }
                                TextField("Answer", text: $answer)
                                    .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                    .padding(.horizontal)
                                Button("Submit") {
                                    if (answer.caseInsensitiveCompare(ModelData().colors[temp].latin) == .orderedSame) {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            answered = true
                                        }
                                        correct = true
                                        questionsRight+=1
                                        SoundManager.instance.playSound(sound: .yes)
                                    } else {
                                        answered = true
                                        correct = false
                                        SoundManager.instance.playSound(sound: .no)
                                    }
                                }
                                .confettiCannon(counter: $questionsRight)
                            }
                            .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height*2.5/8.96)
                        }
                    } else {
                        if correct {
                            VStack {
                                ZStack {
                                    Image("paper")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width*9/4.14, height: UIScreen.main.bounds.height*6/8.96)
                                    Text("Good Job!\nThat's\nCorrect!")
                                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                }
                                if order.count < ModelData().colors.count {
                                    Button("Next") {
                                        while order.contains(temp) {
                                            temp = Int.random(in: 0...ModelData().colors.count-1)
                                        }
                                        order.append(temp)
                                        answered = false
                                        answer = ""
                                    }
                                } else {
                                    Button("Get Score") {
                                        finished = true
                                    }
                                }
                            }
                            .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height*2.5/8.96)
                        } else {
                            VStack {
                                ZStack {
                                    Image("paper")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width*9/4.14, height: UIScreen.main.bounds.height*6/8.96)
                                    VStack {
                                        Text("That's not\nthe answer...")
                                            .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                        if latinToEnglish {
                                            Text("The answer was\n"+ModelData().colors[temp].english+".")
                                                .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                                .foregroundColor(trueColors[ModelData().colors[temp].english])
                                        } else {
                                            Text("The answer was\n"+ModelData().colors[temp].latin+".")
                                                .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                                        }
                                    }
                                }
                                if order.count < ModelData().colors.count {
                                    Button("Next") {
                                        while order.contains(temp) {
                                            temp = Int.random(in: 0...ModelData().colors.count-1)
                                        }
                                        order.append(temp)
                                        answered = false
                                        answer = ""
                                    }
                                } else {
                                    Button("Get Score") {
                                        finished = true
                                    }
                                }
                            }
                            .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height*2.5/8.96)
                        }
                    }
                } else {
                    VStack {
                        Text("Are you ready for the quiz?")
                            .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                        Text("What type of quiz would you like?")
                        HStack {
                            Button("Latin To English!") {
                                temp = Int.random(in: 0...ModelData().colors.count-1)
                                order.append(temp)
                                begun = true
                                latinToEnglish = true
                                oldCoinAmount = modelData.profile.coinAmount
                            }
                            Button("English To Latin!") {
                                temp = Int.random(in: 0...ModelData().colors.count-1)
                                order.append(temp)
                                begun = true
                                oldCoinAmount = modelData.profile.coinAmount
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ColorsQuiz_Previews: PreviewProvider {
    static var previews: some View {
        ColorsQuiz()
            .environmentObject(ModelData())
    }
}
