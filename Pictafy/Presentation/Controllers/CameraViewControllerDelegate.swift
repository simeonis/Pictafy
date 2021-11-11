//
//  CameraViewControllerDelegate.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-11.
//

import UIKit

public protocol CameraViewControllerDelegate {
//    func cameraAccessGranted()
//    func cameraAccessDenied()
    func noCameraDetected()
    func cameraSessionStarted()
    
    func didCapturePhoto()
    
    //    func didSavePhoto()
    func didFinishProcessingPhoto(_ image: UIImage)
    func didFinishSavingWithError(_ image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer)
    
//    func didChangeMaximumVideoDuration(_ duration: Double)
}
