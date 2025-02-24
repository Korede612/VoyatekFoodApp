//
//  OptionCell.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import UIKit

class OptionCell: UICollectionViewCell {
    
    static let identifier: String = "OptionCell"
    
    var titleLabel: UILabel = UILabel.headerTextLabel(fontSize: 14)
    var optionData: OptionData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        cornerRadius = 4
    }
    
    func configureViews() {
        contentView.addSubview(titleLabel)
        titleLabel.anchor(
            trailing: contentView.trailingAnchor,
            leading: contentView.leadingAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )
        titleLabel.centerAnchor(axis: .vertical, on: contentView)
        titleLabel.textAlignment = .center
    }
    
    func configure(with optionData: OptionData) {
        self.optionData = optionData
        titleLabel.text = optionData.title
        if optionData.isSelected {
            backgroundColor = .selectedBlue
            titleLabel.textColor = .white
        } else {
            titleLabel.textColor = .label
            backgroundColor = .unSelected
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
