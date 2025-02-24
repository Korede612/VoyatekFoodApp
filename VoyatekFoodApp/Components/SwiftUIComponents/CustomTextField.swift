//
//  CustomTextField.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var description: String? // Optional description
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Title Label
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
            
            // TextField with Border
            TextField(placeholder, text: $text)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            
            // Optional Description
            if let description = description {
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 2)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CustomTextField(title: "", placeholder: "", text: .constant(""))
}
