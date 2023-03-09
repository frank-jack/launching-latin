//
//  Confirmation.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/21/22.
//

import SwiftUI

struct Confirmation: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var confirmationCode = ""
    let username: String
    
    var body: some View {
        VStack {
            Text("Username: \(username)")
            TextField("Confirmation Code sent to your email", text: $confirmationCode)
            Button("Confirm", action: {sessionManager.confirm(username: username, code: confirmationCode)})
            Button("Cancel", action: sessionManager.showLogIn)
        }
        .padding()
    }
}

struct Confirmation_Previews: PreviewProvider {
    static var previews: some View {
        Confirmation(username: "JFrank")
    }
}
