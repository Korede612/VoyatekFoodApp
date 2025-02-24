//
//  CameraOptions.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import SwiftUI

struct CameraOptions: View {
    
    @Binding var showCameraPicker: Bool
    @Binding var showPhotoLibraryPicker: Bool
    
    var body: some View {
        HStack {
            // Camera Button
            Button(action: { showCameraPicker = true }) {
                VStack {
                    Image("Camera")
                        .font(.system(size: 24)) // Adjust icon size
                    Text("Take Picture")
                        .font(.footnote) // Adjust text size
                }
                .padding()
                .frame(maxWidth: .infinity)
                .cornerRadius(4)
                .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.border, lineWidth: 2) // Properly styled border
                    )
            }
            
            // Upload Button
            Button(action: { showPhotoLibraryPicker = true }) {
                VStack {
                    Image("UploadSimple")
                        .font(.system(size: 24)) // Adjust icon size
                    Text("Upload Images")
                        .font(.footnote) // Adjust text size
                }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(4)
                    .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.border, lineWidth: 2) // Properly styled border
                        )
            }
        }
    }
}

#Preview {
    CameraOptions(showCameraPicker: .constant(false), showPhotoLibraryPicker: .constant(false))
}
