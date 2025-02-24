//
//  CustomOptionViewViewModel.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import Combine
import Foundation

class CustomOptionViewViewModel: NSObject {
    @Published var options: [OptionData] = []
    
    @Published var selectedIndex: Int = 0
    
    init(options: [String]) {
        self.options = options.map { Option(title: $0)}
        super.init()
        guard options.count > 0 else { return }
        self.options[0].isSelected = true
        selectedIndex = 0
    }
    
    func handleSelection(at index: Int) {
        guard options.count > index else { return }
        options = options.map { Option(title: $0.title)}
        options[index].isSelected = true
        selectedIndex = index
    }
}
