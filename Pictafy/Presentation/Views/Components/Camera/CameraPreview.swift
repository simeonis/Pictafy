//
//  CameraPreviewView.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-11.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import UIKit
import AVFoundation

class CameraPreview: UIView {
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
        }
        return layer
    }
    
    var session: AVCaptureSession? {
        get {
            return videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
