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
    fileprivate let photoOutput = AVCapturePhotoOutput()
    fileprivate var takePhotoCompletion: ((UIImage) -> Void)?

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
        captureSession?.addOutput(photoOutput)


        //preview
        let captureVideoPreview = AVCaptureVideoPreviewLayer(session: captureSession)!
        captureVideoPreview.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoPreview = captureVideoPreview
    }
    


}

extension AVSelfCamera: AVCapturePhotoCaptureDelegate {
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        guard let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer), let selfTaken = UIImage(data: imageData) else {
            //TODO: Handle error
            print("error")
            return
        }
        stop()
        takePhotoCompletion?(selfTaken)
    }
}

extension AVSelfCamera: SelfCamera {

    func start() {
        captureSession?.startRunning()
    }

    func stop() {
        captureSession?.stopRunning()
    }

    func takePhoto(completion: @escaping (UIImage) -> Void) {
        takePhotoCompletion = completion
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        settings.previewPhotoFormat = previewFormat

        photoOutput.capturePhoto(with: settings, delegate: self)
    }

}
