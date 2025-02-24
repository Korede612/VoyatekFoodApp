//
//  FoodItemCell.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import Kingfisher
import UIKit

class FoodItemCell: UITableViewCell {
    
    static let reseuseIdentifier = "CompetitionCell"
    
    let containerView = UIView.customShadowView()
    
    private let foodNameLabel: UILabel = UILabel.headerTextLabel(fontSize: 16)
    private let foodImage: UIImageView = UIImageView()
    private let fireIconView = UIImageView(frame: .zero)
    private let caloriesLabel = UILabel.textLabel(fontSize: 12)
    private let favIcon = UIImageView(frame: .zero)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(containerView)
        
        containerView.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor, paddingTop: 8, paddingBottom: 8)
        
        containerView.addSubview(foodImage)
        containerView.addSubview(foodNameLabel)
        containerView.addSubview(fireIconView)
        containerView.addSubview(caloriesLabel)
        containerView.addSubview(favIcon)
        
        containerView.backgroundColor = .systemBackground
        containerView.cornerRadius = 4
        containerView.clipsToBounds = true
        setupUI()
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.border.cgColor
    }
    
    func setupUI() {
        layoutFoodNameLabel()
        layoutFoodImage()
        layoutFireIconView()
        layoutCaloriesLabel()
        layoutFavIcon()
    }
    
    func layoutFoodNameLabel() {
        foodNameLabel.anchor(top: foodImage.bottomAnchor, trailing: trailingAnchor, leading: leadingAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 36)
    }
    
    func layoutFoodImage() {
        foodImage.anchor(top: containerView.topAnchor, trailing: containerView.trailingAnchor, leading: containerView.leadingAnchor, width: 30, height: 137)
    }
    
    func layoutFireIconView() {
        fireIconView.anchor(
            top: foodNameLabel.bottomAnchor,
            leading: foodNameLabel.leadingAnchor,
            paddingTop: 4,
            width: 16,
            height: 16)
        fireIconView.image = UIImage(named: "fire")
    }
    
    func layoutCaloriesLabel() {
        caloriesLabel.anchor(top: fireIconView.topAnchor, leading: fireIconView.trailingAnchor, paddingLeft: 4)
    }
    
    func confire(with model: FoodItem) {
        foodImage.kf.setImage(with: URL(string: model.foodImages.first?.imageURL ?? ""))
        
        foodNameLabel.text = model.name
        caloriesLabel.text = "\(model.calories) Calories"
    }
    
    func layoutFavIcon() {
        favIcon.anchor(trailing: containerView.trailingAnchor, paddingRight: 16, width: 18, height: 18)
        favIcon.centerAnchor(axis: .vertical, on: foodNameLabel)
        favIcon.image = UIImage(named: "heart")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
