//
//  InterestingUsersTableViewCell.swift
//  LTios
//
//  Created by Paul Bénéteau on 18/08/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit

class InterestingUsersTableViewCell: UITableViewCell {
    
    private var didSetupConstraints = false
    
    let queue = SerialOperationQueue()
    
    var user = InterestingUser()
    
    var bubble = RoundShadowView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // add subviews
        contentView.addSubview(bubble)
        
        // constraints
        addConstraint()
        
        // initializations
        contentView.backgroundColor = .clear
        bubble.image = UIImage(named: "profilePicture")
        bubble.clipsToBounds = true
        bubble.backgroundColor = .red
        bubble.shadowOpacity = 0.1
        bubble.shadowOffset = CGSize(width: 0, height: 10)
        bubble.shadowRadius = 10
        
        bubble.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addConstraint() {
        
        let maxX = Int(contentView.frame.width - contentView.frame.height*0.9 - 20)
        
        let x = Int.random(in: 20 ..< maxX)
        
        bubble.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(contentView.snp.height).multipliedBy(0.9)
            make.centerY.equalTo(contentView)
            make.left.equalTo(x)
        }
        contentView.layoutIfNeeded()
        bubble.layoutIfNeeded()
    }
    
}

