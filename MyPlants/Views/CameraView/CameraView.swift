//
//  CameraView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import SwiftUI
import Photos

struct CameraView: View {
    @EnvironmentObject private var cameraViewModel: CameraViewModel

    
    var body: some View {
        ZStack {
            
            CameraViewRepresentable(
                controller: $cameraViewModel.cameraController,
                capturedImage: $cameraViewModel.capturedImage
            )
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        cameraViewModel.isFlashOn.toggle()
                        cameraViewModel.cameraController?.toggleFlash()
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 48, height: 48)
                            Image("bolt")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(cameraViewModel.isFlashOn ? .accentYellow : .iconsTertiary)
                        }
                    })
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .padding(.top, 44)
                
                Spacer()
                
                Text("Place the plant in the scanner square")
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.bottom, 16)
                
                HStack {
                    Button(action: {
                        Task {
                            await cameraViewModel.requestPhotoLibraryAccessAndLoadImages()
                        }
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 60, height: 60)
                            Image("gallery")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        cameraViewModel.cameraController?.capturePhoto()
                    }, label: {
                        Circle()
                            .fill(.white)
                            .frame(width: 52, height: 52)
                            .padding(3)
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        cameraViewModel.isShowingGuide = true
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 60, height: 60)
                            Image("guide")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    })
                }
                .frame(height: 60)
                .padding(.horizontal, 16)
                .padding(.bottom, 122)
                .sheet(isPresented: $cameraViewModel.isShowingGuide) {
                    InstructionsView()
                }
            }
            
            Image("frame")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 32)
            
            if cameraViewModel.showPhotoStrip {
                ZStack {
                    Color.black.opacity(0.8)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                cameraViewModel.showPhotoStrip.toggle()
                            }
                        }

                    VStack {
                        Spacer()
                        PhotoStripView(
                            photos: $cameraViewModel.recentPhotos,
                            selectedImage: $cameraViewModel.capturedImage, showPhotoStrip: $cameraViewModel.showPhotoStrip
                        )
                        .padding(.bottom, 20)
                    }
                }
                .zIndex(1)
            }

            CameraPreview(capturedImage: $cameraViewModel.capturedImage)
        }
        .animation(.easeInOut(duration: 0.2), value: cameraViewModel.showPhotoStrip)
        .animation(.easeInOut(duration: 0.2), value: cameraViewModel.capturedImage)
        .alert(isPresented: $cameraViewModel.showPermissionAlert) {
            Alert(
                title: Text("Allow access to the Gallery in the settings"),
                message: Text("This is necessary to identify your plants and diseases"),
                primaryButton: .default(Text("Settings")) {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}


//#Preview {
//    CameraView()
//}
