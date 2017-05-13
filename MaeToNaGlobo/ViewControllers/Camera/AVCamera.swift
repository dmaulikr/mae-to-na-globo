//
//  AVCamera.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import AVFoundation
import UIKit

class AVSelfCamera: NSObject {

    fileprivate var captureSession: AVCaptureSession?
    fileprivate(set) var videoPreview = CALayer()

    override init() {
        super.init()

        //Make sure the device can handle video


        let devices = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .front).devices
        let frontalCamera = devices?.first

        guard let videoDevice = frontalCamera,
            let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
                return
        }
        captureSession = AVCaptureSession()

        //input
        captureSession?.addInput(deviceInput)

        //output

        //preview
        let captureVideoPreview = AVCaptureVideoPreviewLayer(session: captureSession)!
        captureVideoPreview.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoPreview = captureVideoPreview
    }
    

    func takePhoto() -> UIImage {
        return UIImage()
    }
}

extension AVSelfCamera: SelfCamera {

    func start() {
        captureSession?.startRunning()
    }

    func stop() {
        captureSession?.stopRunning()
    }
    
}
