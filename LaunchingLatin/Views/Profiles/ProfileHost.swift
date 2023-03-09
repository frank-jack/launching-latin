//
//  ProfileHost.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/15/22.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    if editMode?.wrappedValue == .active {
                        Button("Cancel", role: .cancel) {
                            draftProfile = modelData.profile
                            editMode?.animation().wrappedValue = .inactive
                        }
                    }
                    Spacer()
                    //EditButton()
                }

                if editMode?.wrappedValue == .inactive {
                    ProfileSummary(profile: modelData.profile)
                } else { //not viable
                    ProfileEditor(profile: $draftProfile)
                        .onAppear {
                            draftProfile = modelData.profile
                        }
                        .onDisappear {
                            modelData.profile = draftProfile
                            if !modelData.profile.prefersNotifications {
                                UIApplication.shared.unregisterForRemoteNotifications()
                            } else {
                                UIApplication.shared.registerForRemoteNotifications()
                            }
                            let params = ["userId": modelData.profile.userId, "prefersNotifications": String(modelData.profile.prefersNotifications), "coinAmount": String(modelData.profile.coinAmount), "storage": modelData.profile.storage.description] as! Dictionary<String, String>
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
                        }
                }
            }
            .padding()
        }
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
            .environmentObject(SessionManager())
    }
}

