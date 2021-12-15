//
//  CameraViewControllerDelegate.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-11.
//  Group - 2: Shae Simeoni: zpa9, Rita Singh: 991573398, Seth Climenhaga: 991599894

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
