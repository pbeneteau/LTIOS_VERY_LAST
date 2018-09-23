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
    
    var containerView = RoundCornerShadowView()
    
    var scLoginButton = SCSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        snapchatImage.image = UIImage(named: "SnapchatLoginImage")
        
        view.addSubview(snapchatImage)
        view.addSubview(containerView)
        
        containerView.addSubview(scLoginButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    
}

// MARK: Constraints
extension SnapchatLoginViewController {
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if !didSetupConstraints {
            
            containerView.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(self.view).multipliedBy(0.9)
                make.height.equalTo(self.view).multipliedBy(0.75)
                make.bottom.equalTo(self.view).offset(10)
                make.centerX.equalTo(self.view)
            }
            
            snapchatImage.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(self.containerView)
                make.height.equalTo(self.snapchatImage.snp.width).multipliedBy(0.3625)
                make.bottom.equalTo(self.containerView.snp.top)
                make.centerX.equalTo(self.view)
            }
            
            scLoginButton.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(self.containerView).multipliedBy(0.8)
                make.height.equalTo(60)
                make.bottom.equalTo(self.containerView).offset(-30)
                make.centerX.equalTo(self.containerView)
            }
            
            scLoginButton = SCSDKLoginButton() { (success : Bool, error : Error?) in
                print(success)
            }
        }
        
    }
    
}


