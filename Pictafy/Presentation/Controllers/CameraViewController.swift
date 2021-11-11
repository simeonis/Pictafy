//
//  CameraViewController.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-11.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController{
    
    // MARK: Vars
    public var preferredStartingCameraType: AVCaptureDevice.DeviceType?
    public var preferredStartingCameraPosition: AVCaptureDevice.Position?
    
    public var delegate: CameraViewControllerDelegate?
    
    //@IBOutlet var cameraButton:UIButton!
    
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice!
    
    var stillImageOutput: AVCapturePhotoOutput!
    var stillImage: UIImage?
    
    ///current capture session
    let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "session queue")
    
    //Private Output Variables 
    private var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
            super.viewDidLoad()
             
            configure()
    }
    
    // MARK: Device Configuration
    private func configure() {
        /// Get the front and back-facing camera for taking photos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .unspecified)
         
        for device in deviceDiscoverySession.devices {
            if device.position == .back {
                backFacingCamera = device
            } else if device.position == .front {
                frontFacingCamera = device
            }
        }
         
        currentDevice = backFacingCamera
         
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: currentDevice) else {
            return
        }
        
        stillImageOutput = AVCapturePhotoOutput()
        
        captureSession.addInput(captureDeviceInput)
        captureSession.addOutput(stillImageOutput)
        
        // Provide a camera preview
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(cameraPreviewLayer!)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.frame = view.layer.frame
                 
        // Bring the camera button to front
        //view.bringSubviewToFront(cameraButton)
        captureSession.startRunning()
        
    }
    
    // MARK: Public Action Methods
    public func takePhoto() {
        sessionQueue.async {
             let photoSettings = AVCapturePhotoSettings()
             
//             if self.videoDeviceInput!.device.isFlashAvailable {
//                 photoSettings.flashMode = self.flashMode
//             }
             
             self.photoOutput?.capturePhoto(with: photoSettings, delegate: self)
        }
     }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            return
        }
         
        // Get the image from the photo buffer
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
         
        stillImage = UIImage(data: imageData)
    }
}

