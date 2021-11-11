//
//  CameraUserEvents.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-11.
//

import SwiftUI

public class CameraUserEvents: ObservableObject {
    @Published public var didAskToCapturePhoto = false
    @Published public var didAskToRotateCamera = false
    @Published public var didAskToChangeFlashMode = false
    
    @Published public var didAskToRecordVideo = false
    @Published public var didAskToStopRecording = false
    
    public init() {
        
    }
}
