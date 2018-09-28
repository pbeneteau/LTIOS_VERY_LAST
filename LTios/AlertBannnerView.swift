//
//  AlertBannnerView.swift
//  LTios
//
//  Created by Paul Bénéteau on 26/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit

class AlertBannnerView: UIView {
    
    var containerView = RoundShadowView()
    
    var titleLabel =  UILabel()
    var descriptionLabel = UILabel()
    
    var type: BannerType = .closePeople
    
    init(type: BannerType, title: String, description: String) {
        super.init(frame: .zero)
        self.type = type
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
        addSubview(containerView)
        
        containerView.backgroundColor = .white
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 18)
        descriptionLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        
        
        switch type {
        case .message:
            titleLabel.textColor = Color.AlertBanner.Message.title
            descriptionLabel.textColor = Color.AlertBanner.Message.description
            break
        case .closePeople:
            titleLabel.textColor = Color.AlertBanner.ClosePeople.title
            descriptionLabel.textColor = Color.AlertBanner.ClosePeople.description
        case .ghost:
            titleLabel.textColor = Color.AlertBanner.Ghost.title
            descriptionLabel.textColor = Color.AlertBanner.Ghost.description
        case .unreachable:
            titleLabel.textColor = Color.AlertBanner.Unreachable.title
            descriptionLabel.textColor = Color.AlertBanner.Unreachable.description
            break
        }
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self)
            make.center.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView).multipliedBy(0.7)
            make.height.equalTo(21)
            make.left.equalTo(containerView).offset(20)
            make.top.equalTo(containerView).offset(20)
        }
        
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView).multipliedBy(0.7)
            make.height.equalTo(21)
            make.left.equalTo(containerView).offset(20)
            make.top.equalTo(titleLabel).offset(3)
        }
    }
    
    
}

