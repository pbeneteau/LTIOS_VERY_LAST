//
//  InterestingUserCircle.swift
//  LTios
//
//  Created by Paul Bénéteau on 18/08/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit
import Spring

class InterestingUserBubble: SpringView {
    
    private var didSetupConstraints = false
    
    private var shadowLayer: CAShapeLayer!
    private var fillColor: UIColor = .red
    
    var userPhoto = RoundImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //layer.cornerRadius = self.frame.height
        
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//
//            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.frame.height).cgPath
//            shadowLayer.fillColor = fillColor.cgColor
//
//            shadowLayer.shadowColor = UIColor.black.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 5)
//            shadowLayer.shadowOpacity = 0.09
//            shadowLayer.shadowRadius = 10
//
//            layer.insertSublayer(shadowLayer, at: 0)
//        }
    }
    
    func didTap() {
        self.animation = "pop"
        self.force = 0.1
        self.duration = 0.8
        self.animate()
    }

    func commonInit() {
        backgroundColor = .red

        self.addSubview(userPhoto)
        
        userPhoto.contentMode = .scaleAspectFill
        
        addConstraint()
    }
    
    func addConstraint() {

        if !didSetupConstraints {
            
            userPhoto.snp.makeConstraints { (make) -> Void in
                make.height.width.equalTo(self)
                make.center.equalTo(self)
            }
            didSetupConstraints = true
        }
    }    
}
