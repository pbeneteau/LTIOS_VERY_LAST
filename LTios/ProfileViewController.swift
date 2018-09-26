//
//  ProfileViewController.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-31.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit
import FirebaseAuth
import SCSDKLoginKit

class ProfileViewController: ModalViewViewController {
    
    private var containerView = UIView()
    
    private var settingsButton = UIButton()
    
    private var profilePictureView = RoundShadowImageView()
    
    private var usernameLabel = UILabel()
    private var badgeLabel = UILabel()
    private var lineView = UIView()
    private var block1 = UIImageView()
    
    private var contactsBox = roundedCornerView()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        
        profilePictureView.contentMode = .scaleAspectFill
        
        settingsButton.setImage(UIImage(named: "SettingsButton"), for: .normal)
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        containerView.addSubview(settingsButton)
        
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        usernameLabel.textColor = Color.Profile.publicName
        usernameLabel.textAlignment = .center
        containerView.addSubview(usernameLabel)
        
        badgeLabel.font = UIFont.boldSystemFont(ofSize: 15)
        badgeLabel.textColor = Color.Profile.badge
        badgeLabel.textAlignment = .center
        containerView.addSubview(badgeLabel)
        
        lineView.backgroundColor = Color.separatorLine
        containerView.addSubview(lineView)
        
        block1.image = #imageLiteral(resourceName: "profile_block_1")
        block1.contentMode = .scaleAspectFill
        
        containerView.addSubview(block1)
        containerView.addSubview(profilePictureView)
        
        contactsBox.backgroundColor = Color.roundedBlockView
        contactsBox.withShadow = true
        contactsBox.cornerRadius = 10
        containerView.addSubview(contactsBox)
        
        addNotificationsObserver()
        
        handleSnapchatLogin()
    }
    
    func handleSnapchatLogin() {
        
        if  SCSDKLoginClient.isUserLoggedIn  {
            // Crash ?
//            SnapchatServices.shared.fetchAvatarURL { url in
//                guard url != nil else { print("[Error] unwrapping Bitmoji url"); return }
//                print(url ?? "Error")
//            }
        }
    }
    
    @objc func didTapSettingsButton() {
        
        let controller: SettingsViewController = SettingsViewController()

        prepareSettingsSegue { end in
            self.segueToSettingsVC(controller: controller)
        }
    }
    
    @objc func didTapLogOutButton() {
        
        do { try Auth.auth().signOut() }
        catch let error {
            print("[Error] signing out: \(error.localizedDescription)")
        }
    }
    
    @objc func didUpdateUserProfile() {
        
        usernameLabel.text = mainUserInstance.fullName
        badgeLabel.text = mainUserInstance.publicName
        
        if mainUserInstance.photo == nil {
            StorageService.shared.downloadUserPicture(uid: mainUserInstance.uid) { photo in
                guard let photo = photo else { print("[Error] unwrapping user photo"); return }
                self.profilePictureView.image = photo
            }
        } else {
            self.profilePictureView.image = mainUserInstance.photo
        }
    }
    
}

// MARK: Norifications Observer
extension ProfileViewController {
    
    func addNotificationsObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdateUserProfile), name: Notification.Name(rawValue:"didUpdateUserInformation"), object: nil)
    }
}

// MARK: Animations
extension ProfileViewController {
    
    
    func prepareSettingsSegue(completion: @escaping(Bool) -> Void) {
        
        settingsButton.isHidden = true
        
        profilePictureView.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(95)
            make.left.equalTo(25)
            make.top.equalTo(25)
        }
        
        UIView.animate(withDuration: TimeInterval(0.5), animations: {
            self.view.layoutIfNeeded()
            
            self.usernameLabel.alpha = 0
            self.badgeLabel.alpha = 0
            self.lineView.alpha = 0
            self.block1.alpha = 0
            self.contactsBox.alpha = 0
            
        }, completion: { end in
            completion(true)
        })
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
    }
    
    override func updateViewConstraints() {
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.9)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view)
        }
        settingsButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(33)
            make.height.equalTo(33)
            make.right.equalTo(containerView).inset(20)
            make.top.equalTo(containerView).inset(20)
        }
        profilePictureView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView).multipliedBy(0.3125)
            make.height.equalTo(profilePictureView.snp.width)
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView).offset(40)
        }
        usernameLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView).multipliedBy(0.7)
            make.height.equalTo(25)
            make.centerX.equalTo(containerView)
            make.top.equalTo(profilePictureView.snp.bottom).offset(15)
        }
        badgeLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView).multipliedBy(0.7)
            make.height.equalTo(25)
            make.centerX.equalTo(containerView)
            make.top.equalTo(usernameLabel.snp.bottom).offset(3)
        }
        lineView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView).multipliedBy(0.3)
            make.height.equalTo(0.5)
            make.centerX.equalTo(containerView)
            make.top.equalTo(badgeLabel.snp.bottom).offset(8)
        }
        block1.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView).multipliedBy(0.9)
            make.height.equalTo(89)
            make.centerX.equalTo(containerView)
            make.top.equalTo(lineView.snp.bottom).offset(20)
        }
        contactsBox.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView).multipliedBy(0.9)
            make.height.equalTo(containerView).multipliedBy(0.35)
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(containerView).offset(-75)
        }
        
        super.updateViewConstraints()
    }
}

// MARK: Segues
extension ProfileViewController {
    
    func segueToSettingsVC(controller: SettingsViewController) {
        
        controller.view.frame = self.containerView.bounds
        controller.view.backgroundColor = .clear
        
        self.addChildViewController(controller)
        self.containerView.addSubview(controller.view)
    }
}
