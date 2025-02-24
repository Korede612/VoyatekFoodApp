//
//  HeaderView.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import SwiftUI

struct HeaderView<RightContent: View>: View {
    var title: String?
    var onBack: (() -> Void)?
    var rightContent: RightContent?

    init(title: String? = nil, onBack: (() -> Void)? = nil, @ViewBuilder rightContent: () -> RightContent) {
        self.title = title
        self.onBack = onBack
        self.rightContent = rightContent()
    }

    var body: some View {
        ZStack {
            HStack {
                // Back Button
                if let onBack = onBack {
                    Button(action: onBack) {
                        Image("backButton")
                            .resizable()
                            .frame(width: 40, height: 40)
                        //                    .onTapGesture(perform: onBack)
                    }
                }
                
                // Title (Optional)
                if let title = title {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading, onBack == nil ? 0 : 8)
                }
                
                Spacer()
                
                // Right-side Content (Optional)
                if let rightContent = rightContent {
                    rightContent
                }
            }
            .padding()
            .background(Color(.clear))
            
            VStack {
                Spacer()
                Divider()
            }
        }
    }
}


#Preview {
    HeaderView(title: "Add new food", onBack: {}, rightContent: {})
}
