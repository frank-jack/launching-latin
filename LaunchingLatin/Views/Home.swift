//
//  Home.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/13/22.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

struct Home: View {
    @EnvironmentObject var modelData: ModelData
    @ObservedObject var sessionManager = SessionManager()
    init() {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Palatino-Roman", size: 34)!]
    }
    @State var showHome = false
    @State private var showingProfile = false
    @State private var rocketLaunched = false
    @State private var coinAmount = 0
    @State private var prefersNotifications = true
    @State private var storage: [Int] = []
    //@State private var coinText = "Daily 100 Coins"
    //@State private var coinsCollected = false
    var body: some View {
        if showHome {
            VStack {
                NavigationView {
                    VStack {
                        NavigationLink("Numbers") {
                            NumbersDisplay()
                        }
                        NavigationLink("Colors") {
                            ColorsDisplay()
                        }
                        NavigationLink("Shapes") {
                            ShapesDisplay()
                        }
                        NavigationLink("Nature") {
                            NaturalsDisplay()
                        }
                        NavigationLink("Phrases") {
                            PhrasesDisplay()
                        }
                        NavigationLink("Store") {
                            StoreDisplay(items: modelData.store)
                        }
                        /*if !coinsCollected {
                            Button(coinText) {
                                coinsCollected = true
                            }
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        } else {
                            Text(Date(), style: .time)
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }*/
                    }
                    .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                    .background(
                        ZStack {
                            Color.blue.opacity(0.1).ignoresSafeArea(.all)
                            Image("bigBanner")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/0.414, height: UIScreen.main.bounds.height*18/8.96)
                        })
                    .toolbar {
                        ToolbarItem {
                            Button {
                                showingProfile.toggle()
                            } label: {
                                Label("User Profile", systemImage: "person.crop.circle")
                            }
                        }
                    }
                    .sheet(isPresented: $showingProfile) {
                        ProfileHost()
                            .environmentObject(modelData)
                            .environmentObject(sessionManager)
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                HStack {
                    HStack {
                        Text(String(modelData.profile.coinAmount))
                        Image("coin")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    Spacer()
                    Button("Sign Out") {
                        sessionManager.signOut()
                        showHome = false
                        rocketLaunched = false
                    }
                }
                .padding()
            } 
        } else {
            ZStack {
                ZStack {
                    Image("roman")
                        .resizable()
                        .frame(width: 300, height: 500)
                    //if case .session(_) = sessionManager.authState {
                        //Image("goldCrown")
                            //.resizable()
                            //.frame(width: 100, height: 100)
                            //.position(x: UIScreen.main.bounds.width/2+7.5, y: 305)
                    //}
                }
                VStack {
                    Text("Welcome to Launching Latin!")
                        .multilineTextAlignment(.center)
                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                        .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/8.96)
                    if case .session(_) = sessionManager.authState {
                        Button("Click to Continue") {
                            print("W: "+UIScreen.main.bounds.width.description+" H: "+UIScreen.main.bounds.height.description)
                            print("Username: "+String(Amplify.Auth.getCurrentUser()!.username))
                            if Amplify.Auth.getCurrentUser()!.username != "guest" {
                                print("NOT A GUEST")
                                var getRequest = URLRequest(url: URL(string: "https://7snhsr8dgc.execute-api.us-east-1.amazonaws.com/dev/userdata?"+Amplify.Auth.getCurrentUser()!.userId)!)
                                getRequest.httpMethod = "GET"
                                getRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                                let getSession = URLSession.shared
                                let getTask = getSession.dataTask(with: getRequest, completionHandler: { data, response, error -> Void in
                                    print(response!)
                                    do {
                                        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                                        print("json start")
                                        print(json)
                                        print("json end")
                                        if let jsonArray = json["Items"] as? [[String:Any]],
                                           let items = jsonArray.first {
                                            coinAmount = items["coinAmount"] as! Int
                                            print(String(coinAmount))
                                        } else {
                                            let params = ["userId": Amplify.Auth.getCurrentUser()!.userId, "coinAmount": "0", "storage": "[]"] as! Dictionary<String, String>
                                            var request = URLRequest(url: URL(string: "https://7snhsr8dgc.execute-api.us-east-1.amazonaws.com/dev/userdata")!)
                                            request.httpMethod = "POST"
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
                                        }
                                        if let jsonArray = json["Items"] as? [[String:Any]],
                                           let items = jsonArray.first {
                                            storage = items["storage"] as! [Int]
                                            for i in storage {
                                                print("\(i)")
                                            }
                                        }
                                        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
                                            if settings.authorizationStatus == .denied {
                                                prefersNotifications = false
                                            } else if settings.authorizationStatus == .authorized {
                                                prefersNotifications = true
                                            }
                                        })
                                        modelData.profile = Profile(username: Amplify.Auth.getCurrentUser()?.username ?? "error", userId: Amplify.Auth.getCurrentUser()?.userId ?? "error", prefersNotifications: prefersNotifications, coinAmount: coinAmount, storage: storage)
                                    } catch {
                                        print("error")
                                    }
                                })
                                getTask.resume()
                            } else {
                                print("GUEST")
                                UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
                                    if settings.authorizationStatus == .denied {
                                        modelData.profile = Profile(username: "guest", userId: "1", prefersNotifications: false, coinAmount: 0, storage: [])
                                    } else if settings.authorizationStatus == .authorized {
                                        modelData.profile = Profile(username: "guest", userId: "1", prefersNotifications: true, coinAmount: 0, storage: [])
                                    }
                                })
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                showHome = true
                            }
                            withAnimation(.easeInOut(duration: 3.0)) {
                                rocketLaunched = true
                            }
                        }
                        .position(x: UIScreen.main.bounds.width/2, y: -UIScreen.main.bounds.height/8.96/2)
                    }
                    if !rocketLaunched {
                        Image("rocket")
                            .resizable()
                            .frame(width: 500, height: 500)
                            .position(x: -100, y: UIScreen.main.bounds.height+100)
                            .transition(.offset(x: UIScreen.main.bounds.width+200, y: -UIScreen.main.bounds.height-300))
                    }
                    Spacer()
                    switch sessionManager.authState {
                        case .logIn:
                            LogIn()
                                .environmentObject(sessionManager)
                            
                        case .signUp:
                            SignUp()
                                .environmentObject(sessionManager)
                            
                        case .confirmCode(let username):
                            Confirmation(username: username)
                                .environmentObject(sessionManager)
                            
                        case .session(let user):
                            Session(user: user)
                                .environmentObject(sessionManager)
                        case .reset:
                            Reset()
                                .environmentObject(sessionManager)
                    }
                }
            }
        }
    }
}

private func configureAmplify() {
    do {
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.configure()
        print("Amplify configured successfully")
        
    } catch {
        print("could not initialize Amplify", error)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(ModelData())
    }
}
