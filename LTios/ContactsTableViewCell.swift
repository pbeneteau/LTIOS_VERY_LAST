//
//  ContactsTableViewCell.swift
//  LTios
//
//  Created by antoine beneteau on 2017-10-27.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    var didSetupConstraints = false
    
    let queue = SerialOperationQueue()
    
    var cellView = UIView()
    
    var name = UILabel()
    var surname = UILabel()
    var profilePicture = UIImageView()
    var country = UILabel()
    var status = UILabel()
    var lineSeparator = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareForReuse()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.0)
        
        addSubview(cellView)
        
        addSubview(name)
        addSubview(surname)
        addSubview(profilePicture)
        addSubview(country)
        addSubview(status)
        addSubview(lineSeparator)
        
        
        cellView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.11)
        cellView.layer.cornerRadius = 4.0
        
        name.textColor = UIColor(red:0.11, green:0.20, blue:0.35, alpha:1.0)
        name.font = UIFont(name: "Roboto-Regular", size: 16)
        
        surname.textColor = UIColor(red:0.11, green:0.20, blue:0.35, alpha:1.0)
        surname.font = UIFont(name: "Roboto-Bold", size: 16)
        
        country.textColor = UIColor(red:0.42, green:0.42, blue:0.42, alpha:1.0)
        country.font = UIFont(name: "Roboto-Regular", size: 11)
        
        status.textColor = UIColor(red:0.69, green:0.42, blue:0.70, alpha:1.0)
        status.font = UIFont(name: "Roboto-Bold", size: 11)
        
        profilePicture.image = #imageLiteral(resourceName: "profilePicture")
        profilePicture.setRounded(width: 43)
        
        lineSeparator.backgroundColor = .gray
        lineSeparator.alpha = 0.45
        
        updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func updateConstraints() {
        
        if !didSetupConstraints {
            
            profilePicture.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(43)
                make.centerY.equalTo(contentView)
                make.left.equalTo(contentView).offset(14)
            }
            
            name.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(14)
                make.left.equalTo(profilePicture.snp.right).offset(11)
            }
            
            surname.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(14)
                make.left.equalTo(name.snp.right).offset(4)
            }
            
            country.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(name.snp.bottom).offset(3)
                make.left.equalTo(name)
            }
            
            status.snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(contentView)
                make.right.equalTo(contentView).offset(-7)
            }
            
            lineSeparator.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(contentView).multipliedBy(0.9)
                make.centerX.equalTo(contentView)
                make.bottom.equalTo(contentView)
                make.height.equalTo(0.5)
            }
            
            didSetupConstraints = true
            
        }
        super.updateConstraints()
    }
    
}

