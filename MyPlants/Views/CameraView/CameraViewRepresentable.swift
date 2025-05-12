//
//  CameraViewRepresentation.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import UIKit
import SwiftUI

struct CameraViewRepresentable: UIViewControllerRepresentable {
    @Binding var controller: CameraViewController?
    @Binding var capturedImage: UIImage?

    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraVC = CameraViewController()
        cameraVC.onPhotoCapture = { image in
            DispatchQueue.main.async {
                self.capturedImage = image
            }
        }
        DispatchQueue.main.async {
            self.controller = cameraVC
        }
        return cameraVC
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}
