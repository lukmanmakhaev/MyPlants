//
//  PhotoPickerView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var showPhotoStrip: Bool

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPickerView

        init(_ parent: PhotoPickerView) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider,
                  provider.canLoadObject(ofClass: UIImage.self) else {
                return
            }

            provider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.parent.selectedImage = image
                        self.parent.showPhotoStrip = false
                    }
                }
            }
        }
    }
}

//#Preview {
//    PhotoPickerView(selectedImage: <#Binding<UIImage?>#>, showPhotoStrip: <#Binding<Bool>#>)
//}
