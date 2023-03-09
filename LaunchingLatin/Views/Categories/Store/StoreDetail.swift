//
//  StoreDetail.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/28/22.
//

import SwiftUI

struct StoreDetail: View {
    @EnvironmentObject var modelData: ModelData
    var item: StoreItem
    @State private var text1 = ""
    @State private var text2 = "Buy?"
    @State private var text3 = ""
    @State private var oldCoinAmount = 0
    @State private var bought = false
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            VStack {
                ZStack {
                    if !bought {
                        item.image
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)
                            .transition(.offset(x: UIScreen.main.bounds.width, y: -UIScreen.main.bounds.height))
                    }
                    item.image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(5)
                }
                Text(item.name)
                    .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                HStack {
                    Text(String(item.cost))
                    Image("coin")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                if modelData.profile.storage.contains(item.id) {
                    Text("You already own this!")
                } else {
                    Button(text2) {
                        if modelData.profile.coinAmount < item.cost {
                            text1 = "Sorry... You don't have enough coins to buy this."
                        } else {
                            if text2 == "Buy?" {
                                text2 = "Are you sure?"
                                text3 = "Cancel"
                                oldCoinAmount = modelData.profile.coinAmount
                            } else {
                                withAnimation(.easeInOut(duration: 2)){
                                    bought = true
                                }
                                SoundManager.instance.playSound(sound: .cash)
                                modelData.profile.coinAmount = oldCoinAmount-item.cost
                                modelData.profile.storage.append(item.id)
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
                                    text2 = "Purchase Complete"
                                }
                            }
                        }
                    }
                }
                Text(text1)
                Button(text3) {
                    text2 = "Buy?"
                    text3 = ""
                }
                .foregroundColor(.red)
            }
        }
    }
}

struct StoreDetail_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetail(item: ModelData().store[0])
            .environmentObject(ModelData())
    }
}
