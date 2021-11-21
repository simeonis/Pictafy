//
//  photoview.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-11.
//

import SwiftUI
import AVFoundation

struct Camera: UIViewControllerRepresentable {
    
    // MARK: Vars
    @ObservedObject var events: CameraUserEvents
    var imageT: Binding<UIImage?>
    
    private var preferredStartingCameraType: AVCaptureDevice.DeviceType
    private var preferredStartingCameraPosition: AVCaptureDevice.Position
    
    // MARK: Public Methods
    public init(events: CameraUserEvents,
                image: Binding<UIImage?>,
                preferredStartingCameraType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera,
                preferredStartingCameraPosition: AVCaptureDevice.Position = .back) {
        
        self.events = events
        
        self.imageT = image
           
        self.preferredStartingCameraType = preferredStartingCameraType
        self.preferredStartingCameraPosition = preferredStartingCameraPosition
        
    }
    
    public func makeUIViewController(context: Context) -> CameraViewController {
        let cameraViewController = CameraViewController()
        cameraViewController.delegate = context.coordinator
           
        cameraViewController.preferredStartingCameraType = preferredStartingCameraType
        cameraViewController.preferredStartingCameraPosition = preferredStartingCameraPosition
           
        return cameraViewController
    }
    
    public func updateUIViewController(_ cameraViewController: CameraViewController, context: Context) {
        if events.didAskToCapturePhoto {
            cameraViewController.takePhoto()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: Coordinator
    public class Coordinator: NSObject, CameraViewControllerDelegate {
        
        var parent: Camera
        
        
        init(_ parent: Camera) {
            self.parent = parent
        }
        
        public func cameraSessionStarted() {
            print("Camera session started")
        }
            
        public func noCameraDetected() {
            print("No camera detected")
        }
            
        public func didCapturePhoto() {
            parent.events.didAskToCapturePhoto = false
            print("didCapturePhoto")
        }
            
        public func didFinishProcessingPhoto(image: UIImage) {
            //TODO
            print("didFinishProcessingPhoto seth")
            parent.imageT.wrappedValue = image
        }
                    
        public func didFinishSavingWithError(image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer) {
            //TODO
            print("didFinishSavingWithError")
        }
    }
}
