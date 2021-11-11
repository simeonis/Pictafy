//
//  photoview.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-11.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    
    // MARK: Vars
    @ObservedObject var events: CameraUserEvents
    
    private var preferredStartingCameraType: AVCaptureDevice.DeviceType
    private var preferredStartingCameraPosition: AVCaptureDevice.Position
    
    // MARK: Public Methods
    public init(events: CameraUserEvents,
                preferredStartingCameraType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera,
                preferredStartingCameraPosition: AVCaptureDevice.Position = .back) {
        self.events = events
           
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
        
        var parent: CameraView
        
        init(_ parent: CameraView) {
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
            
        public func didFinishProcessingPhoto(_ image: UIImage) {
            //TODO
            print("didFinishProcessingPhoto")
        }
                    
        public func didFinishSavingWithError(_ image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer) {
            //TODO
            print("didFinishSavingWithError")
        }
    }
}
