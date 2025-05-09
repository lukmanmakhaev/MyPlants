//
//  CameraViewRepresentation.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import UIKit
import AVFoundation
import SwiftUI

struct CameraViewRepresentable : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CameraViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
