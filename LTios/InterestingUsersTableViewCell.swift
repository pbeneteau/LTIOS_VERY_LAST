//
//  InterestingUsersTableViewCell.swift
//  LTios
//
//  Created by Paul Bénéteau on 18/08/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit

class InterestingUsersTableViewCell: UITableViewCell {

    var didSetupConstraints = false
    
    let queue = SerialOperationQueue()
    
    var user = [InterestingUser]()
    
    var bubble = InterestingUserBubble()
    var optionalBubble = InterestingUserBubble()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        
        bubble.userPhoto.image = UIImage(named: "profilePicture")
        
        contentView.addSubview(bubble)
        
        addConstraints()
    }
    
    func addConstraints() {
        
        if !didSetupConstraints {
            
            let maxX = Int(contentView.frame.width - contentView.frame.height - 20)
            
            let x = Int.random(in: 20 ..< maxX)

            bubble.snp.makeConstraints { (make) -> Void in
                make.height.width.equalTo(contentView.snp.height)
                make.centerY.equalTo(contentView)
                make.left.equalTo(x)
            }
            
            didSetupConstraints = true
        }
    }

}
