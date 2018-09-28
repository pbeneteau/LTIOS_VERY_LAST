//
//  SnapchatLoginViewController.swift
//  LTios
//
//  Created by Paul Bénéteau on 22/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit
import SCSDKLoginKit

class SnapchatLoginViewController: UIViewController {
    
    var didSetupConstraints = false
    
    var snapchatImage = UIImageView()
    
    var containerView = RoundShadowView()
    
    var loginObserver: SCSDKLoginStatusObserver!
    
    var SCLoginButton = UIButton()
    
    var backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        snapchatImage.image = UIImage(named: "SnapchatLoginImage")
        
        SCLoginButton.setBackgroundImage(UIImage(named: "SnapchatLoginButton"), for: .normal)
        SCLoginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        
        backButton.setBackgroundImage(UIImage(named: "BackButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(backButton)
        view.addSubview(snapchatImage)
        view.addSubview(containerView)
        
        containerView.addSubview(SCLoginButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    @objc func loginButtonTapped(_ sender: Any) {
        
        SCLoginButton.isUserInteractionEnabled = false
        SCLoginButton.alpha = 0.8
        
        SCSDKLoginClient.login(from: self, completion: { success, error in
            
            if let err = error {
                print("[Error] logging in to Snapchat: " + err.localizedDescription)
                self.SCLoginButton.isUserInteractionEnabled = true
                self.SCLoginButton.alpha = 1
                return
            }
            
            if success {
                print("Successfuly logged in to Snapchat")
            }
        })
    }
    
    @objc func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

// MARK: Constraints
extension SnapchatLoginViewController {
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if !didSetupConstraints {
            
            containerView.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(view).multipliedBy(0.9)
                make.height.equalTo(view).multipliedBy(0.75)
                make.bottom.equalTo(view).offset(10)
                make.centerX.equalTo(view)
            }
            
            snapchatImage.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(containerView)
                make.height.equalTo(snapchatImage.snp.width).multipliedBy(0.3625)
                make.bottom.equalTo(containerView.snp.top)
                make.centerX.equalTo(view)
            }
            
            SCLoginButton.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(317)
                make.height.equalTo(SCLoginButton.snp.width).multipliedBy(0.29535)
                make.bottom.equalTo(containerView).offset(-45)
                make.centerX.equalTo(containerView)
            }
            
            backButton.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(34)
                make.height.equalTo(29)
                make.top.equalTo(view).offset(40)
                make.left.equalTo(view).offset(20)
            }
        }
    }
}


