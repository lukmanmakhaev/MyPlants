//
//  CameraViewModel.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 11.05.2025.
//

import Foundation
import UIKit
import Photos

@MainActor
final class CameraViewModel: ObservableObject {
    @Published var cameraController: CameraViewController?
    @Published var capturedImage: UIImage? = nil
    @Published var isFlashOn: Bool = false
    @Published var isShowingGuide: Bool = false
    @Published var showPhotoStrip: Bool = false
    @Published var showPermissionAlert: Bool = false
    @Published var recentPhotos: [UIImage] = []

    func toggleFlash() {
        cameraController?.toggleFlash()
        isFlashOn.toggle()
    }
    
    func resetCapturedImage() {
        capturedImage = nil
    }
    
    func requestPhotoLibraryAccessAndLoadImages(limit: Int = 10) async {
           let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)

           switch status {
           case .authorized, .limited:
               await loadRecentPhotos(limit: limit)
               showPhotoStrip = true

           case .notDetermined:
               let newStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
               if newStatus == .authorized || newStatus == .limited {
                   await loadRecentPhotos(limit: limit)
                   showPhotoStrip = true
               }

           case .denied, .restricted:
               showPermissionAlert = true

           @unknown default:
               break
           }
       }

       private func openSettings() {
           guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
           if UIApplication.shared.canOpenURL(settingsURL) {
               UIApplication.shared.open(settingsURL)
           }
       }

    private func loadRecentPhotos(limit: Int) async {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = limit

        let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        let imageManager = PHCachingImageManager()
        let targetSize = PHImageManagerMaximumSize

        let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.resizeMode = .none
        requestOptions.isSynchronous = false
        requestOptions.isNetworkAccessAllowed = true


        let indexedImages: [(Int, UIImage)] = await withTaskGroup(of: (Int, UIImage?)?.self) { group in
            for index in 0..<assets.count {
                let asset = assets.object(at: index)
                group.addTask {
                    await withCheckedContinuation { continuation in
                        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .default, options: requestOptions) { image, _ in
                            continuation.resume(returning: (index, image))
                        }
                    }
                }
            }

            var results: [(Int, UIImage)] = []
            for await result in group {
                if let (index, image) = result, let image = image {
                    results.append((index, image))
                }
            }
            return results
        }

        let sortedImages = indexedImages
            .sorted(by: { $0.0 < $1.0 })
            .map { $0.1 }

        self.recentPhotos = sortedImages
    }
}
