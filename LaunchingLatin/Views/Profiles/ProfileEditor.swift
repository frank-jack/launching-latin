//
//  ProfileEditor.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/16/22.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                Text(profile.username)
                //TextField("Username", text: $profile.username)
            }
            .listRowBackground(Color.blue.opacity(0.3))
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications").bold()
            }
            .listRowBackground(Color.blue.opacity(0.3))
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
