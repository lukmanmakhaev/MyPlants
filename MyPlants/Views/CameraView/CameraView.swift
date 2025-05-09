//
//  CameraView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import SwiftUI

struct CameraView: View {
    var body: some View {
        ZStack {
            // Camera feed
            CameraViewRepresentable()
                .ignoresSafeArea()
            
            VStack (spacing: 0 ){
                HStack {
                    Button(action: {
                        
                    }, label: {
                        ZStack {
                            // Circular background
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 48, height: 48)
                            
                            Image("bolt")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    })
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
                
                Spacer()
                
                Text("Place the plant in the scanner square")
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.bottom, 16)
                
                HStack {
                    Button(action: {
                        
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
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        VStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 52, height: 52)
                                .clipShape(Circle())
                                .padding(5)
                                .overlay(Circle().stroke(.white, lineWidth: 2))
                               
                        }
                    })
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Button(action: {
                        
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
                    .padding(.horizontal, 16)
                }
                .frame(height: 60)
                .padding(.horizontal, 16)
                .padding(.bottom, 88)
            }
            
            
            Image("frame")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 32)
        }
    }
}


#Preview {
    CameraView()
}
