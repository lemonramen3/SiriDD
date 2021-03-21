//
//  __App.swift
//  弟弟
//
//  Created by xinghao wang on 2021/3/11.
//

import SwiftUI
import Intents

@main
struct __App: App {
    
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
                 INPreferences.requestSiriAuthorization({status in
                 // Handle errors here
             })
         }
    }
}
