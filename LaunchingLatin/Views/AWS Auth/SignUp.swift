//
//  SignUp.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/21/22.
//

import SwiftUI

struct SignUp: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var username = ""
    @State var password = ""
    @State var email = ""
    @State private var tempText = ""
    var body: some View {
        VStack {
            Spacer()
            TextField("Username", text: $username)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Text(tempText)
            Button("Sign Up") {
                if password.count < 8 {
                    tempText = "Password must be at least 8 characters"
                } else {
                    sessionManager.signUp(username: username, email: email, password: password)
                }
            }
            Spacer()
            Button("Already have an account? Log in.", action: sessionManager.showLogIn)
        }
        .padding()
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
