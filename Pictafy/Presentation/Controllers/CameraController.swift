//
//  CameraViewController.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-11.
//

import UIKit
import AVFoundation

class CameraController: UIViewController{
    
    
    // MARK: Vars
    @IBOutlet var cameraButton:UIButton!
    
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice!
    
    var stillImageOutput: AVCapturePhotoOutput!
    var stillImage: UIImage?
    
    let captureSession = AVCaptureSession()
    
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
        view.bringSubviewToFront(cameraButton)
        captureSession.startRunning()
        
    }
    
    // MARK: Action methods
    @IBAction func capture(sender: UIButton) {
            // Set photo settings
            let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            photoSettings.isHighResolutionPhotoEnabled = true
            photoSettings.flashMode = .auto
             
            stillImageOutput.isHighResolutionCaptureEnabled = true
            stillImageOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}

extension CameraController: AVCapturePhotoCaptureDelegate {
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

