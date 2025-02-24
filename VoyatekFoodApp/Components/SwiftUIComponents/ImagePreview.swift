//
//  ImagePreview.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import SwiftUI

import SwiftUI

struct ImagePreview: View {
    @Binding var images: [UIImage]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(images, id: \.self) { image in
                    ZStack(alignment: .bottomTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                            .cornerRadius(4)

                        // Delete Button
                        Button(action: { removeImage(image: image) }) {
                            Image("close")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                        .offset(x: -5, y: -5) // Adjust position
                    }
                }
            }
            .padding(.top, 8)
        }
    }

    func removeImage(image: UIImage) {
        images.removeAll(where: { $0 == image })
    }
}


#Preview {
    ImagePreview(images: .constant([]))
}
