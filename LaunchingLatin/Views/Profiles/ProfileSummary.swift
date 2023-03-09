//
//  ProfileSummary.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/15/22.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

struct ProfileSummary: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var sessionManager: SessionManager
    @State private var showDelete = false
    @State var username = ""
    @State var confirm = ""
    @State private var text = "Delete Account"
    @State private var parentalGate = 0
    @State private var temp1 = 0
    @State private var temp2 = 0
    @State var answer = ""
    var profile: Profile
    var body: some View {
        ScrollView {
            if parentalGate == 1 {
                VStack {
                    Text("Parental Gate")
                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                    Text("Ask Your Parents For Help")
                    Spacer()
                        .frame(height: 175)
                    Text("What is\n"+String(temp1)+" x "+String(temp2)+"?")
                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                    TextField("Answer", text: $answer)
                    Button("Submit") {
                        if answer == String(temp1*temp2) {
                            parentalGate = 2
                        }
                    }
                    Spacer()
                        .frame(height: 300)
                    Button("Cancel") {
                        parentalGate = 0
                    }
                    .foregroundColor(.red)
                }
            } else {
                if !showDelete {
                    VStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(profile.username)
                                .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                            Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                            HStack {
                                Text("Coins: \(profile.coinAmount)")
                                //Coin(radius: 30)
                                Image("coin")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            Spacer()
                            Text("Treasure Trove")
                                .font(.custom("Palatino-Roman", fixedSize: 26).weight(.black))
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .top, spacing: 0) {
                                    ForEach(profile.storage, id: \.self) {
                                        StoreFront(item: ModelData().store[$0])
                                    }
                                }
                            }
                            .frame(height: UIScreen.main.bounds.height*1.85/8.96)
                        }
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height*3.25/8.96)
                        if parentalGate == 0 {
                            Button("See Links") {
                                parentalGate = 1
                                temp1 = Int.random(in: 1...10)
                                temp2 = Int.random(in: 1...10)
                            }
                        }
                        if parentalGate == 2 {
                            Text(.init("[Privacy Policy](https://www.freeprivacypolicy.com/live/e112924e-87f8-4f62-bd7b-9ed9ace05390)"))
                            Text(.init("[Visit Our Website](http://launchinglatin.com/)"))
                        }
                        if Amplify.Auth.getCurrentUser()!.username != "guest" {
                            Button("Delete Account") {
                                showDelete = true
                            }
                            .foregroundColor(.red)
                        }
                    }
                } else {
                    VStack {
                        Text("Delete Account")
                            .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                        Spacer()
                        TextField("Username", text: $username)
                        Spacer()
                        TextField("Type 'CONFIRM'", text: $confirm)
                        Button(text) {
                            if username.caseInsensitiveCompare(Amplify.Auth.getCurrentUser()!.username) == .orderedSame && confirm == "CONFIRM" {
                                print("Ready to Delete")
                                if text == "Delete Account" {
                                    text = "Are you sure?"
                                } else {
                                    print("deleting")
                                    Amplify.Auth.deleteUser()
                                }
                            }
                        }
                        .foregroundColor(.red)
                        Button("Cancel") {
                            showDelete = false
                            username = ""
                            confirm = ""
                            text = "Delete Account"
                        }
                    }
                }
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
            .environmentObject(ModelData())
            .environmentObject(SessionManager())
    }
}
