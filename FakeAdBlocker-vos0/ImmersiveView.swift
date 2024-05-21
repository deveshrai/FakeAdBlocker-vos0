//
//  ImmersiveView.swift
//  FakeAdBlocker-vos0
//
//  Created by Devesh Rai on 21/05/24.
//

import SwiftUI
import RealityKit

var isTrans=false;
func setTrans(val:Bool){
    isTrans=val
}
struct ImmersiveView: View {

    @Environment(ImageTrackingModel.self) var model
//    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        RealityView { content in
            content.add(model.setupContentEntity())
        }
        .task{
            model.setMaterial(which: isTrans)
        }
        
        .task {
            await model.runSession()
        }
        .task {
            await model.processImageTrackingUpdates()
        }
        .task {
            await model.monitorSessionEvents()
        }
//        .onReceive(timer, perform: { input in
//            model.setMaterial(which: isTrans)
//        })
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
        .environment(ImageTrackingModel())
}
