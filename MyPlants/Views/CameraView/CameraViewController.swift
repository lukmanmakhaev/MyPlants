//
//  CameraViewController.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import UIKit
import AVFoundation
import SwiftUI

class CameraViewController: UIViewController {
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    private func setupCamera() {
        // Initialize the capture session
        let session = AVCaptureSession()
        session.sessionPreset = .photo
        
        // Select the back camera
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: backCamera) else {
            print("Failed to access back camera")
            return
        }
        
        // Add input to session
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        // Set up the preview layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        self.videoPreviewLayer = previewLayer
        self.captureSession = session
        
        // Start the session
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreviewLayer?.frame = view.bounds
    }
}
