//
//  AddFoodView.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import SwiftUI

struct AddFoodView: View {
    var onBack: (() -> Void)?
    
    @State private var images: [UIImage] = []
    @State private var showCameraPicker = false
    @State private var showPhotoLibraryPicker = false
    
    @State private var nameField: String = ""
    @State private var descriptionField: String = ""
    @State private var selectedOption: String? = nil
    @State private var calories: String = ""
    @State private var tags: String = ""
    
    var isFormValid: Bool {
        return !nameField.isEmpty &&
        !descriptionField.isEmpty &&
        !(selectedOption?.isEmpty ?? true) &&
        !calories.isEmpty &&
        !tags.isEmpty &&
        images.count > 0
        }
    
    var category: [String]
    
    var body: some View {
        VStack {
            HeaderView(title: "Add New Food", onBack: onBack, rightContent: {})
                .frame(height: 70)
            
            
            VStack {
                CameraOptions(
                    showCameraPicker: $showCameraPicker,
                    showPhotoLibraryPicker: $showPhotoLibraryPicker
                )
                
                // Image Preview
                if $images.count > 0 {
                    ImagePreview(images: $images)
                        .frame(height: 50)
                }
            }
            .padding(.horizontal, 16)
            
            VStack(spacing: 16) {
                CustomTextField(title: "Name", placeholder: "Enter food name", text: $nameField)
                    .frame(height: 74)
                
                CustomMultilineTextField(title: "Description", placeholder: "Enter food description", text: $descriptionField, description: nil, maxHeight: 200)
                
                CustomDropdown(title: "Category", placeholder: "Enter Food Category", options: category, selectedOption: $selectedOption)
                
                CustomTextField(title: "Calories", placeholder: "Enter number of calories", text: $calories)
                
                CustomTextField(title: "Tags", placeholder: "Add a tag", text: $tags, description: "Press enter once you've typed a tag.")
                
                
            }
            .padding(.horizontal, 16)
            
            Spacer()
            Button(action: {
                
            }, label: {
                Text("Add Food")
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .cornerRadius(4)
                    .background(!isFormValid ? Color.disabledButton : Color.selectedBlue)
                    .tint(!isFormValid ? Color.disabledButtonText : Color.white)
                    
            })
            .disabled(!isFormValid)
            
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
                .sheet(isPresented: $showCameraPicker) {
                    ImagePicker(sourceType: .camera) { image in
                        if let image = image { images.append(image) }
                    }
                }
                .sheet(isPresented: $showPhotoLibraryPicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        if let image = image { images.append(image) }
                    }
                }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    AddFoodView(onBack: {}, category: [])
}
