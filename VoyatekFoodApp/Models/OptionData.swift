//
//  OptionData.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import Foundation

protocol OptionData {
    var title: String { get set }
    var isSelected: Bool { get set }
}

struct Option: OptionData {
    var title: String
    var isSelected: Bool = false
}

extension Option {
    init (title: String) {
        self.title = title
    }
}
