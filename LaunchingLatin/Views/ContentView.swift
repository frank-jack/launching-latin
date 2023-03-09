//
//  ContentView.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/13/22.
//

//W: 414.0 H: 896.0 at iPhone 11
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            Home()
            //Test()
        }
        .multilineTextAlignment(.center)
        .font(.custom("Palatino-Roman", fixedSize: 18).weight(.black))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
