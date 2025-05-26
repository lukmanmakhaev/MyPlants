//
//  FailureBannerView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 15.05.2025.
//

import SwiftUI

struct FailureBannerView: View {
    var title: String
    @Binding var isShowingGuide: Bool
    @EnvironmentObject private var cameraViewModel: CameraViewModel
    @EnvironmentObject private var identificationVM: IdentificationViewModel
    
    var body: some View {
        VStack (spacing: 12) {
            
            Text(title)
                .tracking(0.2)
                .font(.system(size: 14, weight: .medium))
                .frame(maxWidth: .infinity)
                .foregroundStyle(.main)
            
            
            HStack {
                Button(action: {
                    isShowingGuide = true
                }, label: {
                    Text("Instructions")
                        .tracking(0.2)
                        .padding(16)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.main)
                        .overlay(
                            Capsule()
                                .stroke(.main, lineWidth: 2)
                        )
                        .clipShape(Capsule())
                })
                .sheet(isPresented: $isShowingGuide) {
                    InstructionsView()
                }
                
                Button(action: {
                    cameraViewModel.resetCapturedImage()
                    identificationVM.reset()
                }, label: {
                    Text("Try again")
                        .tracking(0.2)
                        .padding(16)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .background(.main)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                })
            }
        }
        .padding(16)
        .overlay(alignment: .bottomLeading, content: {
            Image(.banner1)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 60)
                .padding(.bottom, -15)
            
        })
        .overlay(alignment: .topTrailing, content: {
            Image(.banner2)
                .resizable()
                .scaledToFit()
                .frame(width: 102, height: 42)
                .padding(.top, -15)
        })
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


#Preview {
    FailureBannerView(title: "Unfortunately, it was not possible to recognize your plant or its disease", isShowingGuide: .constant(false))
}
