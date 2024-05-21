//
//  ImageTrackingModel.swift
//  FakeAdBlocker-vos0
//
//  Created by Devesh Rai on 21/05/24.
//

import ARKit
import SwiftUI
import RealityKit
import Observation

@Observable
@MainActor




class ImageTrackingModel {

//    public var materials1 = UnlitMaterial(color: UIColor.black.withAlphaComponent(0.65))
//    public var materials2 = UnlitMaterial(color: UIColor.black)
    private var trans = false;
    
    private let session = ARKitSession()

    private let imageTrackingProvider = ImageTrackingProvider(
        referenceImages: ReferenceImage.loadReferenceImages(inGroupNamed: "Target2")
    )

    private var contentEntity = Entity()
    private var entityMap: [UUID: Entity] = [:]
    public

    // MARK: - Public

    func setupContentEntity() -> Entity {
        return contentEntity
    }

    func runSession() async {
        do {
            if ImageTrackingProvider.isSupported {
                try await session.run([imageTrackingProvider])
                print("[\(type(of: self))] [\(#function)] session.run")
            }
        } catch {
            print(error)
        }
    }

    func processImageTrackingUpdates() async {
        //print("[\(type(of: self))] [\(#function)] called")

        for await update in imageTrackingProvider.anchorUpdates {
            //print("[\(type(of: self))] [\(#function)] anchorUpdates")
            
            updateImage(update.anchor)

        }
    }
    func process()
    {
//        var aU:AnchorUpdate<ImageAnchor>
//        Task{
//            for await update in imageTrackingProvider.anchorUpdates {
//                aU=update
//            }
//        }
//        updateImage(aU.anchor)
        
    }
    
    func monitor()
    {
        
    }

    func monitorSessionEvents() async {
        for await event in session.events {
            switch event {
            case .authorizationChanged(type: _, status: let status):
                //print("Authorization changed to: \(status)")
                if status == .denied {
                    //print("Authorization status: denied")
                }
            case .dataProviderStateChanged(dataProviders: let providers, newState: let state, error: let error):
                //print("Data provider changed: \(providers), \(state)")
                if let error {
                    //print("Data provider reached an error state: \(error)")
                }
            @unknown default:
                fatalError("Unhandled new event type \(event)")
            }
        }
    }

    // MARK: - Private

    private func updateImage(_ anchor: ImageAnchor) {
        if entityMap[anchor.id] == nil {
            let entity = ModelEntity(mesh: .generateBox(width: 0.3, height: 0.01, depth: 0.2, cornerRadius: 0))//.generateSphere(radius: 0.05))
            
            var material = UnlitMaterial(color: UIColor.black)
            if(trans)
            {
                material=UnlitMaterial(color: UIColor.black.withAlphaComponent(0.65))
            }
            entity.model?.materials = [material]
            entityMap[anchor.id] = entity
            contentEntity.addChild(entity)
        }

        if anchor.isTracked {
            entityMap[anchor.id]?.transform = Transform(matrix: anchor.originFromAnchorTransform)
        }
    }
    func setMaterial(which:Bool)
    {
        trans=which;
    }
}
