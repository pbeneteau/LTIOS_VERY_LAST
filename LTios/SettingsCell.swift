//
//  SettingsCell.swift
//  LTios
//
//  Created by Paul Bénéteau on 15/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit


class SettingsCell: UITableViewCell {
    
    internal var userSettings = mainUserInstance.settings
    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var segueIcon: UIImageView!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    var indexPath: IndexPath!
    var position: SettingsCellPosition!
    
    var type: SettingsCellType!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        
        if position == .first {
            backgroundImage.image = UIImage(named: "CellBackgroundTop")
        } else if position == .last {
            backgroundImage.image = UIImage(named: "CellBackgroundBot")
        } else if position == .middle {
            backgroundImage.image = UIImage(named: "CellBackgroundMid")
        } else {
            backgroundImage.image = UIImage(named: "CellBackgroundSolo")
        }
        
        let section = indexPath.section
        let row = indexPath.row
        
        titleLabel.text = userSettings?.getName(section: section, row: row)
        descriptionLabel.text = userSettings?.getDescription(section: section, row: row)
        switchButton.isOn = userSettings?.getState(section: section, row: row) ?? false
        type = userSettings?.getType(section: section, row: row)
        
        if type == .onOff {
            switchButton.isHidden = false
            segueIcon.isHidden = true
        } else if type == .segue {
            switchButton.isHidden = true
            segueIcon.isHidden = false
        }
        
        switchButton.addTarget(self, action: #selector(updateSettings), for: UIControlEvents.valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        
        descriptionLabel.sizeToFit()
        
        let frame = backgroundImage.frame
        
        if position == .first {
            backgroundImage.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(frame.width)
                make.height.equalTo(frame.height)
                make.bottom.equalTo(containerView)
                make.centerX.equalTo(containerView)
            }
        } else if position == .last {
            backgroundImage.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(frame.width)
                make.height.equalTo(frame.height)
                make.top.equalTo(containerView)
                make.centerX.equalTo(containerView)
            }
        } else {
            backgroundImage.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(frame.width)
                make.height.equalTo(frame.height)
                make.center.equalTo(containerView)
            }
        }
        
    }
    
    @objc func updateSettings() {
        
        if type == .onOff {
            
            DatabaseService.shared.updateOnOffSettings(section: self.indexPath.section, row: self.indexPath.row, state: switchButton.isOn) { success in
            }
        }
    }
    
}

enum SettingsCellPosition {
    case first
    case middle
    case last
    case solo
}

enum SettingsCellType {
    case onOff
    case segue
    case link
}



