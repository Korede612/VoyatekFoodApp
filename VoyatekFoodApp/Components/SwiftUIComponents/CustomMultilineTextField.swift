//
//  CustomMultilineTextField.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import SwiftUI

struct CustomMultilineTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var description: String? // Optional bottom text
    var maxHeight: CGFloat = 150 // Maximum height before scrolling
    
    @State private var textHeight: CGFloat = 40 // Initial height
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Title Label
            Text(title)
                .font(.caption)
                .foregroundColor(.black)

            ZStack(alignment: .topLeading) {
                
                
                // Multi-line Text Editor
                TextEditor(text: $text)
                    .frame(minHeight: 40, maxHeight: min(textHeight, maxHeight)) // Auto-expand up to maxHeight
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .onChange(of: text) { _ in adjustTextHeight() }
                
                // Placeholder (shown only if text is empty)
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(12)
                        .allowsHitTesting(false) // Ensures tap still focuses text field
                }
            }
            .frame(maxWidth: .infinity)

            // Optional Bottom Description
            if let description = description {
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 2)
            }
        }
        .onAppear { adjustTextHeight() } // Ensure height is correct on load
    }

    // Dynamically adjust text height based on content
    private func adjustTextHeight() {
        let size = CGSize(width: UIScreen.main.bounds.width - 40, height: .infinity)
        let estimatedHeight = text.boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        ).height
        
        textHeight = max(40, estimatedHeight + 20) // Add padding
    }
}
