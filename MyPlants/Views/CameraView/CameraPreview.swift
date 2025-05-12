//
//  CameraPreview.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 11.05.2025.
//

import SwiftUI

struct CameraPreview: View {
    @Binding var capturedImage: UIImage?
    var body: some View {
        VStack {
            if let image = capturedImage {
                ZStack {
                    Color.black.ignoresSafeArea()
                    
                    GeometryReader { geometry in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .ignoresSafeArea()
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                capturedImage = nil
                            }, label: {
                                ZStack {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .frame(width: 48, height: 48)
                                    Image("close")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            })
                        }
                        .padding(.top, 44)
                        
                        Spacer()
                        
                        HStack (spacing: 8) {
                            Button(action: {
                                
                            }) {
                                Text("Identification")
                                    .padding(16)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .background(.main)
                                    .foregroundStyle(.white)
                                    .clipShape(Capsule())
                            }
                            
                            Button(action: {
                                
                            }) {
                                Text("Diagnostics")
                                    .padding(16)
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .background(.main)
                                    .foregroundStyle(.white)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 122)
                }
            }
        }
    }
}


#Preview {
    CameraPreview(capturedImage: .constant(UIImage(named: "dev")))
}
