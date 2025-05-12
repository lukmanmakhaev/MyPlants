//
//  CameraViewController.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    private let session = AVCaptureSession()
    private var photoOutput = AVCapturePhotoOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var flashOn = false
    
    var onPhotoCapture: ((UIImage) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSession()
    }
    
    private func configureSession() {
        session.beginConfiguration()
        
        // Camera input
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input) else {
            return
        }
        session.addInput(input)
        
        // Photo output
        guard session.canAddOutput(photoOutput) else { return }
        session.addOutput(photoOutput)
        session.sessionPreset = .photo
        
        session.commitConfiguration()
        
        // Preview Layer
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        startSession()
    }
    
    private func startSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
    
    func toggleFlash() {
        flashOn.toggle()
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = flashOn ? .on : .off
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            return
        }
        
        onPhotoCapture?(image)
    }
}
