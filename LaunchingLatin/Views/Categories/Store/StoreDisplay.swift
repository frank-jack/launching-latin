//
//  Store.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/28/22.
//

import SwiftUI

struct StoreDisplay: View {
    @EnvironmentObject var modelData: ModelData
    var items: [StoreItem]
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            VStack {
                ZStack {
                    Image("banner")
                        .resizable()
                        .frame(width: 600, height: 300)
                        .position(x: UIScreen.main.bounds.width/2, y: 0)
                    Text("Store")
                        .font(.custom("Palatino-Roman", fixedSize: 34).weight(.black))
                        .position(x: UIScreen.main.bounds.width/2, y: -15)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(items) { storeItem in
                            NavigationLink {
                                StoreDetail(item: storeItem)
                            } label: {
                                StoreFront(item: storeItem)
                            }
                        }
                    }
                }
                .frame(height: 185)
                .position(x: UIScreen.main.bounds.width/2, y: -50)
            }
        }
        
    }
}

struct StoreDisplay_Previews: PreviewProvider {
    static var previews: some View {
        StoreDisplay(items: ModelData().store)
            .environmentObject(ModelData())
    }
}
