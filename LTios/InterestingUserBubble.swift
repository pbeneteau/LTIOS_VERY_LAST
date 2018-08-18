//
//  InterestingUserCircle.swift
//  LTios
//
//  Created by Paul Bénéteau on 18/08/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit

class InterestingUserBubble: UIView {
    
    var didSetupConstraints = false
    
    var userPhoto = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.height
        userPhoto.layer.cornerRadius = self.frame.height
    }
    
    func commonInit() {
        backgroundColor = .red

        self.addSubview(userPhoto)
        userPhoto.contentMode = .scaleAspectFill
        addConstraints()
    }
    
    func addConstraints() {
        
        if !didSetupConstraints {
            
            userPhoto.snp.makeConstraints { (make) -> Void in
                make.height.width.equalTo(self)
                make.center.equalTo(self)
            }
            
            didSetupConstraints = true
        }
    }
    
}
