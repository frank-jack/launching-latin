//
//  Reset.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/23/22.
//

import SwiftUI

struct Reset: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var username = ""
    @State private var code = ""
    @State private var newPassword = ""
    @State private var showConfirm = false
    @State private var text1 = "Cancel"
    @State private var text2 = ""
    var body: some View {
        VStack{
            if !showConfirm {
                TextField("Username", text: $username)
                Button("Reset Password") {
                    sessionManager.resetPassword(username: username)
                    showConfirm = true
                }
            }
            if showConfirm {
                TextField("Confirmation Code sent to your email", text: $code)
                SecureField("New Password", text: $newPassword)
                Text(text2)
                Button("Confirm New Password") {
                    if newPassword.count < 8 {
                        text2 = "New password must be at least 8 characters"
                    } else {
                        sessionManager.confirmResetPassword(username: username, newPassword: newPassword, confirmationCode: code)
                        text1 = "New Password Confirmed"
                    }
                }
            }
            Button(text1, action: sessionManager.showLogIn)
        }
        .padding()
    }
}

struct Reset_Previews: PreviewProvider {
    static var previews: some View {
        Reset()
    }
}
