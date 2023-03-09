//
//  Session.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/21/22.
//

import SwiftUI
import Amplify

struct Session: View {
    @EnvironmentObject var sessionManager: SessionManager
    //let user: AuthUser
    @State var user: AuthUser
    var body: some View {
        VStack {
            Text("It's time to launch, "+user.username+"!"/*+"\nUserId: "+user.userId*/)
            Spacer()
            Button("Sign Out", action: sessionManager.signOut)
        }
        .padding()
    }
}

struct Session_Previews: PreviewProvider {
    private struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    
    static var previews: some View {
        Session(user: DummyUser())
    }
}
