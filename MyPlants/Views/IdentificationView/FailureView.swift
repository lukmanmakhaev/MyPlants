//
//  FailureView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 14.05.2025.
//

import SwiftUI


struct FailureView: View {
    @State var isShowingGuide: Bool = false
    @EnvironmentObject private var cameraViewModel: CameraViewModel
    @EnvironmentObject private var identificationVM: IdentificationViewModel
    
    var body: some View {
        VStack {
            FailureBannerView(title: "Unfortunately, it was not possible to recognize your plant or its disease", isShowingGuide: $isShowingGuide)
                .environmentObject(cameraViewModel)
                .environmentObject(identificationVM)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.bg)
        
    }
}

#Preview {
    FailureView()
        .environmentObject(CameraViewModel())
        .environmentObject(IdentificationViewModel())
}
