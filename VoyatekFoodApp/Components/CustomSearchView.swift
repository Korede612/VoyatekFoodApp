//
//  CustomSearchView.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import Combine
import UIKit

class CustomSearchView: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
    }
    
    func setupSearchBar() {
        placeholder = "Search foods..."
        searchBarStyle = .minimal
        backgroundColor = UIColor.clear
        
        if let textField = value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.searchBarBg
          textField.layer.cornerRadius = 4
          textField.clipsToBounds = true
          textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
          
          textField.attributedPlaceholder = NSAttributedString(
            string: "Search foods...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
          )
          if let leftView = textField.leftView as? UIImageView {
            leftView.image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = UIColor.lightGray
          }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
