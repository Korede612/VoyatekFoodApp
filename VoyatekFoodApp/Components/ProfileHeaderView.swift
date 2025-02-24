//
//  ProfileHeaderView.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import UIKit
import Combine

class ProfileHeaderView: UIView {
    
    let buttonTapped = PassthroughSubject<Void, Never>()
    
    private let welcomeString: String = "Hey there, "
    
    private let profileImageView: UIImageView = UIImageView(frame: .zero)
    private let welcomeLabel: UILabel = UILabel.headerTextLabel(fontSize: 16)
    private let exciteLabel: UILabel = UILabel.infoLabel(text: "Are you excited to create a tasty dish today?", fontSize: 14)
    
    private let notificationBell = UIImageView(frame: .zero)
    private let notificationButton = UIButton()
    
    var userName: String = "" {
        didSet {
            welcomeLabel.text = welcomeString + userName + "!"
        }
    }
    
    var profileImage: UIImage? = nil {
        didSet {
            profileImageView.image = profileImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layoutUI()
    }
    
    func setupUI() {
        addSubview(profileImageView)
        addSubview(welcomeLabel)
        addSubview(exciteLabel)
        addSubview(notificationBell)
        addSubview(notificationButton)
    }
    
    func layoutUI() {
        layoutProfileImageView()
        layoutWelcomeLabel()
        layoutExcitedLabel()
        layoutNotificationBell()
        layoutNotificationButton()
    }
    
    func layoutProfileImageView() {
        profileImageView.anchor(top: safeTopAnchor, leading: leadingAnchor, paddingTop: 5, width: 42, height: 42)
        profileImageView.cornerRadius = 21
    }
    
    func layoutWelcomeLabel() {
        welcomeLabel.anchor(top: profileImageView.bottomAnchor, trailing: trailingAnchor, leading: profileImageView.leadingAnchor, paddingTop: 4, paddingRight: 20, height: 24)
    }
    
    func layoutExcitedLabel() {
        exciteLabel.anchor(top: welcomeLabel.bottomAnchor, leading: welcomeLabel.leadingAnchor)
        exciteLabel.textColor = UIColor.greyText
    }
    
    func layoutNotificationBell() {
        notificationBell.anchor(top: profileImageView.topAnchor, trailing: trailingAnchor, width: 40, height: 40)
        notificationBell.image = UIImage(named: "bell")
    }
    
    func layoutNotificationButton() {
        notificationButton.anchor(top: profileImageView.topAnchor, trailing: trailingAnchor, width: 40, height: 40)
        notificationButton.addTarget(self, action: #selector(buttonTappedAction), for: .touchUpInside)
    }
    
    @objc private func buttonTappedAction() {
            buttonTapped.send() // Send event when button is tapped
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(userName: String? = nil, profileImage: UIImage? = nil) {
        self.init(frame: .zero)
        self.userName = userName ?? "User Name"
        self.profileImage = profileImage
    }
}
