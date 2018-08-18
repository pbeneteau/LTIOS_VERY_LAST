//
//  ProfileViewController.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-31.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit

class ProfileViewController: ModalViewViewController {
    
    private var containerView = UIView()
    
    private var logoutButton = UIButton()
    private var logoutConfirmationButton = UIButton()
    
    private var settingsButton = UIButton()
    
    private var profilePictureView = roundedImageView()
    private let outerView = UIView()
    
    private var usernameLabel = UILabel()
    private var badgeLabel = UILabel()
    private var lineView = UIView()
    private var block1 = UIImageView()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        
        profilePictureView.image = UIImage(named: "profilePicture")
        profilePictureView.contentMode = .scaleAspectFill
        
        settingsButton.setBackgroundImage(UIImage(named: "ic_settings"), for: .normal)
        containerView.addSubview(settingsButton)
        
        logoutConfirmationButton.backgroundColor = .white
        logoutConfirmationButton.layer.cornerRadius = 3
        logoutConfirmationButton.isHidden = true
        logoutConfirmationButton.alpha = 0
        logoutConfirmationButton.setTitle("  Disconnect   ", for: .normal)
        
        logoutConfirmationButton.setTitleColor(UIColor(red:0.64, green:0.23, blue:1.00, alpha:1.0), for: .normal)
        containerView.addSubview(logoutConfirmationButton)
        
        logoutButton.setBackgroundImage(UIImage(named: "ic_logout"), for: .normal)
        logoutButton.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        containerView.addSubview(logoutButton)
        
        usernameLabel.text = "Hacker"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        usernameLabel.textColor = UIColor(red:0.00, green:0.05, blue:0.25, alpha:1.0)
        usernameLabel.textAlignment = .center
        containerView.addSubview(usernameLabel)
        
        badgeLabel.text = "Explorer"
        badgeLabel.font = UIFont.boldSystemFont(ofSize: 15)
        badgeLabel.textColor = UIColor(red:0.57, green:0.42, blue:0.75, alpha:1.0)
        badgeLabel.textAlignment = .center
        containerView.addSubview(badgeLabel)
        
        lineView.backgroundColor = .gray
        lineView.alpha = 0.2
        containerView.addSubview(lineView)
        
        block1.image = #imageLiteral(resourceName: "profile_block_1")
        view.addSubview(block1)
        
        outerView.addSubview(profilePictureView)
        containerView.addSubview(outerView)
        
        addNotificationsObserver()
        
    }
    
    @objc func didTapLogOutButton() {
        
        logoutConfirmationButton.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.logoutConfirmationButton.alpha = 1
        })
    }
    
    @objc func didUpdateUserProfile() {
        
        self.usernameLabel.text = mainUserInstance.fullName
        self.badgeLabel.text = mainUserInstance.publicName
    }
    
}

class roundedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = self.bounds.size.width / 2.0
        
        self.layer.cornerRadius = radius
        
        self.clipsToBounds = true
    }
}

class roundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = self.bounds.size.width / 2.0
        
        self.layer.cornerRadius = radius
    }
}

// MARK: Constraints
extension ProfileViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowRadius = 5
        
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.15
        outerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        outerView.layer.shadowRadius = 5
    }
    
    override func updateViewConstraints() {
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.bottom).multipliedBy(0.1)
        }
        logoutButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(21)
            make.height.equalTo(25)
            make.left.equalTo(containerView.snp.left).offset(20)
            make.top.equalTo(containerView.snp.top).inset(20)
        }
        logoutConfirmationButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(150)
            make.height.equalTo(35)
            make.left.equalTo(logoutButton.snp.left).offset(-5)
            make.centerY.equalTo(logoutButton.snp.centerY)
        }
        settingsButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(27)
            make.height.equalTo(27)
            make.right.equalTo(containerView.snp.right).inset(20)
            make.top.equalTo(containerView.snp.top).inset(20)
        }
        outerView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.snp.width).multipliedBy(0.3125)
            make.height.equalTo(outerView.snp.width)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(containerView.snp.top).offset(40)
        }
        profilePictureView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(outerView.snp.width)
            make.height.equalTo(profilePictureView.snp.width)
            make.center.equalTo(outerView.snp.center)
        }
        usernameLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(25)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(outerView.snp.bottom).offset(10)
        }
        badgeLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(25)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(usernameLabel.snp.bottom).offset(3)
        }
        lineView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
            make.height.equalTo(0.5)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(badgeLabel.snp.bottom).offset(8)
        }
        block1.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.snp.width).multipliedBy(0.97)
            make.height.equalTo(90)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(lineView.snp.bottom).offset(20)
        }
        super.updateViewConstraints()
    }
}

// MARK: Norifications Observer
extension ProfileViewController {
    
    func addNotificationsObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdateUserProfile), name: Notification.Name(rawValue:"didUpdateUserProfile"), object: nil)
        
    }
}
