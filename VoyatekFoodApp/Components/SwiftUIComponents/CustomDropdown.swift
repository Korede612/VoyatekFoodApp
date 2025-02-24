//
//  CustomDropdown.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import SwiftUI

struct CustomDropdown: View {
    let title: String
    let placeholder: String
    let options: [String]
    @Binding var selectedOption: String?
    
    @State private var isExpanded = false // Controls dropdown visibility
    private let maxDropdownHeight: CGFloat = 150 // Maximum height before scrolling

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Title Label
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            // Dropdown Button
            Button(action: { isExpanded.toggle() }) {
                HStack {
                    Text(selectedOption ?? placeholder)
                        .foregroundColor(selectedOption == nil ? .gray.opacity(0.6) : .black)

                    Spacer()

                    // Arrow Down Icon
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }

            // Dropdown List (Scrollable)
            if isExpanded {
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                                isExpanded = false
                            }) {
                                Text(option)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.white)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .frame(maxHeight: maxDropdownHeight) // Limits height, enables scrolling
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .shadow(radius: 2)
            }
        }
    }
}
