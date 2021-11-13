//
//  CameraViewControllerDelegate.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-11.
//

import UIKit

public protocol CameraViewControllerDelegate {
    func noCameraDetected()
    func cameraSessionStarted()
    
    func didCapturePhoto()
    
    //    func didSavePhoto()
    func didFinishProcessingPhoto(image: UIImage)
    func didFinishSavingWithError(image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer)
    
    //func didChangeMaximumVideoDuration(_ duration: Double)
}
