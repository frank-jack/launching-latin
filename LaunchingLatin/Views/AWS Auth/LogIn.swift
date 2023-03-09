//
//  LogIn.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/21/22.
//

import SwiftUI

struct LogIn: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var sessionManager: SessionManager
    @State var username = ""
    @State var password = ""
    var body: some View {
        VStack {
            Spacer()
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            Button("Forgot your password?", action: sessionManager.showReset)
            Spacer()
            Button("Log In", action: {sessionManager.logIn(username: username, password: password)})
            Spacer()
            Button("Log In as Guest") {
                sessionManager.logIn(username: "guest", password: "abcdefghijklmnopqrstuvwxyz")
                print("Logged In")
            }
            Button("Don't have an account? Sign up.", action: sessionManager.showSignUp)
        }
        .padding()
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
            .environmentObject(ModelData())
    }
}
