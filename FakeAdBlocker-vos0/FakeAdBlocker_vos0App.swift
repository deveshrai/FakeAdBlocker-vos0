//
//  FakeAdBlocker_vos0App.swift
//  FakeAdBlocker-vos0
//
//  Created by Devesh Rai on 21/05/24.
//

import SwiftUI

@main
@MainActor
struct Day34App: App {

    @State private var model = ImageTrackingModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 400, height: 400)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
                .environment(model)
        }
    }
}
