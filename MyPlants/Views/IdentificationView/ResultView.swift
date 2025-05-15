//
//  ResultView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 14.05.2025.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject private var cameraViewModel: CameraViewModel
    @EnvironmentObject private var identificationVM: IdentificationViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    
    var body: some View {
        
        VStack {
            if identificationVM.showError {
                FailureView()
                    .transition(.opacity)
            } else if identificationVM.showIdentification, let result = identificationVM.result {
                withAnimation(.spring()) {
                    IdentificationView(result: result)
                        .transition(.opacity)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if identificationVM.isLoading {
                LoadingView()
                    .transition(.opacity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .animation(.easeInOut(duration: 0.3), value: identificationVM.showIdentification)
        .animation(.easeInOut(duration: 0.3), value: identificationVM.showError)
        .animation(.easeInOut(duration: 0.3), value: identificationVM.isLoading)
        .environmentObject(homeViewModel)
        .environmentObject(cameraViewModel)
        .environmentObject(identificationVM)
    }
}

#Preview {
    ResultView()
        .environmentObject(IdentificationViewModel())
}
