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
    
    //Input Devices =====================================================
    //var backFacingCamera: AVCaptureDevice?
    //var frontFacingCamera: AVCaptureDevice?
    //var currentDevice: AVCaptureDevice!
    private var videoDeviceInput: AVCaptureDeviceInput!
    
    //Outputs ===========================================================
    var stillImageOutput: AVCapturePhotoOutput!
    var stillImage: UIImage?
    
    //Session Variables==================================================
    private enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
    private var setupResult: SessionSetupResult = .success
    ///current capture session
    let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "session queue")
    private var isCaptureSessionRunning = false
    
    //Private Output Variables===========================================
    let photoOutput = AVCapturePhotoOutput()
    
    private var cameraPreviewView = CameraPreviewView()
    
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
            super.viewDidLoad()
             
        // Set up the video preview view.
        cameraPreviewView.session = captureSession
        //cameraPreviewView.videoPreviewLayer.videoGravity = videoGravity
        cameraPreviewView.videoPreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewView.frame = view.frame
        view.addSubview(cameraPreviewView)
        
        getPermissions();
        
        sessionQueue.async {self.configureSession()}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sessionQueue.async {
            switch self.setupResult {
            case .success:
                // Begin Session
                self.captureSession.startRunning()
                self.isCaptureSessionRunning = self.captureSession.isRunning
                
            case .notAuthorized:
                DispatchQueue.main.async {
                    let changePrivacySetting = "Pictafy doesn't have permission to use the camera, please change privacy settings"
                    let message = NSLocalizedString(changePrivacySetting, comment: "Alert message when the user has denied access to the camera")
                    let alertController = UIAlertController(title: "Pictafy", message: message, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                            style: .cancel,
                                                            handler: nil))
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"),
                                                            style: .`default`,
                                                            handler: { _ in
                                                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                                                          options: [:],
                                                                                          completionHandler: nil)
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            case .configurationFailed:
                DispatchQueue.main.async {
                    let alertMsg = "Alert message when something goes wrong during capture session configuration"
                    let message = NSLocalizedString("Unable to capture media", comment: alertMsg)
                    let alertController = UIAlertController(title: "Pictafy", message: message, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                            style: .cancel,
                                                            handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    // MARK: Session Management
    private func getPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // The user has previously granted access to the camera.
            break
            
        case .notDetermined:
            /* The user has not yet been presented with the option to grant
             video access.  Delay session setup until the access request has completed. */
            
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })
            
        default:
            // The user has previously denied access.
            setupResult = .notAuthorized
        }
    }
    
    // Call this on the session queue.
    /// - Tag: ConfigureSession
    private func configureSession() {
        if setupResult != .success {
            return
        }
        
        captureSession.beginConfiguration()
        
        /*
         Do not create an AVCaptureMovieFileOutput when setting up the session because
         Live Photo is not supported when AVCaptureMovieFileOutput is added to the session.
         */
        captureSession.sessionPreset = .photo
        
        // Add video input.
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            // Choose the back dual camera, if available, otherwise default to a wide angle camera.
            
            if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
                defaultVideoDevice = dualCameraDevice
            } else if let dualWideCameraDevice = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) {
                // If a rear dual camera is not available, default to the rear dual wide camera.
                defaultVideoDevice = dualWideCameraDevice
            } else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                // If a rear dual wide camera is not available, default to the rear wide angle camera.
                defaultVideoDevice = backCameraDevice
            } else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                // If the rear wide angle camera isn't available, default to the front wide angle camera.
                defaultVideoDevice = frontCameraDevice
            }
            guard let videoDevice = defaultVideoDevice else {
                print("Default video device is unavailable.")
                setupResult = .configurationFailed
                captureSession.commitConfiguration()
                return
            }
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            
            if captureSession.canAddInput(videoDeviceInput) {
                captureSession.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
                DispatchQueue.main.async {

                }
            } else {
                print("Couldn't add video device input to the session.")
                setupResult = .configurationFailed
                captureSession.commitConfiguration()
                return
            }
        } catch {
            print("Couldn't create video device input: \(error)")
            setupResult = .configurationFailed
            captureSession.commitConfiguration()
            return
        }
        
        // Add the photo output.
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
            
            photoOutput.isHighResolutionCaptureEnabled = true
            photoOutput.isLivePhotoCaptureEnabled = photoOutput.isLivePhotoCaptureSupported
            photoOutput.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported
            photoOutput.isPortraitEffectsMatteDeliveryEnabled = photoOutput.isPortraitEffectsMatteDeliverySupported
            photoOutput.enabledSemanticSegmentationMatteTypes = photoOutput.availableSemanticSegmentationMatteTypes
     
            photoOutput.maxPhotoQualityPrioritization = .quality
            //livePhotoMode = photoOutput.isLivePhotoCaptureSupported ? .on : .off
            //depthDataDeliveryMode = photoOutput.isDepthDataDeliverySupported ? .on : .off
            //portraitEffectsMatteDeliveryMode = photoOutput.isPortraitEffectsMatteDeliverySupported ? .on : .off
            //photoQualityPrioritizationMode = .balanced
            
        } else {
            print("Could not add photo output to the session")
            setupResult = .configurationFailed
            captureSession.commitConfiguration()
            return
        }
        
        captureSession.commitConfiguration()
    }
    
    // MARK: Public Action Methods
    public func takePhoto() {
        sessionQueue.async {
             let photoSettings = AVCapturePhotoSettings()
             
//             if self.videoDeviceInput!.device.isFlashAvailable {
//                 photoSettings.flashMode = self.flashMode
//             }
             
             self.photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
     }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    /// - Tag: DidFinishCaptureFor
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        DispatchQueue.main.async {
            // Flash the screen to signal that SwiftUICam took a photo.
            self.view.layer.opacity = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layer.opacity = 1
            }
            self.delegate?.didCapturePhoto()
        }
    }
    
    /// - Tag: DidFinishProcessing
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else { print("Error capturing photo: \(error!)"); return }
       
        if let photoData = photo.fileDataRepresentation() {
            let dataProvider = CGDataProvider(data: photoData as CFData)
            let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!,
                                    decode: nil,
                                    shouldInterpolate: true,
                                    intent: CGColorRenderingIntent.defaultIntent)
           
            // TODO: implement imageOrientation
            // Set proper orientation for photo
            // If camera is currently set to front camera, flip image
            //          let imageOrientation = getImageOrientation()
           
            // For now, it is only right
            let image = UIImage(cgImage: cgImageRef!, scale: 1, orientation: .right)
           
            //2 options to save
            //First is to use UIImageWriteToSavedPhotosAlbum
            // TODO: implement saving
            //savePhoto(image)
            //Second is adapting Apple documentation with data of the modified image
            //savePhoto(image.jpegData(compressionQuality: 1)!)
           
           
            DispatchQueue.main.async {
                self.delegate?.didFinishProcessingPhoto(image)
            }
        }
   }
}

