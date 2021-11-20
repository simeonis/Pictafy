//
//  CameraActions.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-20.
//

import Foundation

public protocol CameraActions {
    func takePhoto(events: CameraUserEvents)
    func toggleVideoRecording(events: CameraUserEvents)
    func rotateCamera(events: CameraUserEvents)
    func changeFlashMode(events: CameraUserEvents)
}

public extension CameraActions {
    func takePhoto(events: CameraUserEvents) {
        events.didAskToCapturePhoto = true
    }
    
    func toggleVideoRecording(events: CameraUserEvents) {
        if events.didAskToRecordVideo {
            events.didAskToStopRecording = true
        } else {
            events.didAskToRecordVideo = true
        }
    }
    
    func rotateCamera(events: CameraUserEvents) {
        events.didAskToRotateCamera = true
    }
    
    func changeFlashMode(events: CameraUserEvents) {
        events.didAskToChangeFlashMode = true
    }
}
