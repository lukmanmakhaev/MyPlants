//
//  PhotoStripView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 11.05.2025.
//

import SwiftUI
import PhotosUI

struct PhotoStripView: View {
    @Binding var photos: [UIImage]
    @Binding var selectedImage: UIImage?
    @Binding var showPhotoStrip: Bool
    
    @State private var isShowingPhotoPicker = false

    
    var body: some View {
        VStack (spacing: 25) {
            
            Spacer()
            
            HStack (spacing: 8) {
                
                Spacer()
                
                Button {
                    isShowingPhotoPicker = true
                } label: {
                    HStack(spacing: 8) {
                        Text("Open a gallery")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        Image("arrow")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                    }
                }
            }
            .padding(.horizontal, 41)
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(photos, id: \.self) { photo in
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .onTapGesture {
                                    selectedImage = photo
                                    showPhotoStrip.toggle()
                                }
                        }
                    }
                    .padding(.leading)
                }
            }
            .padding(.bottom, 198)
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPickerView(selectedImage: $selectedImage, showPhotoStrip: $showPhotoStrip)
        }
    }
}

#Preview {
    PhotoStripView(photos: .constant([UIImage()]), selectedImage: .constant(UIImage()), showPhotoStrip: .constant(true))
}
