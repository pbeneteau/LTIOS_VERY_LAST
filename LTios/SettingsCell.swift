//
//  SettingsCell.swift
//  LTios
//
//  Created by Paul Bénéteau on 15/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit


class SettingsCell: UITableViewCell {
    
    private var shadowLayer: CAShapeLayer!
    
    var section: Int!
    var row: Int!
    
    var type: SettingsCellType!
    
    @IBOutlet weak var containerView: SettingsCellContainerView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var segueIcon: UIImageView!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        switchButton.addTarget(self, action: #selector(updateSettings), for: UIControlEvents.valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        
        descriptionLabel.sizeToFit()
        
        if type == .onOff {
            switchButton.isHidden = false
            segueIcon.isHidden = true
        } else if type == .segue {
            switchButton.isHidden = true
            segueIcon.isHidden = false
        }
        
    }
    
    @objc func updateSettings() {
        
        if type == .onOff {
            
            DatabaseService.shared.updateOnOffSettings(section: self.section, row: self.row, state: switchButton.isOn) { success in
            }
        }
    }
    
}

class SettingsCellContainerView: UIView {
    
    var shadowLayer: CAShapeLayer!
    var position: SettingsCellPosition!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = false
        
        if shadowLayer == nil {
            
            shadowLayer = CAShapeLayer()
            
            var path = UIBezierPath()
            
            if position == .first {
                path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 10, height:  10))
            } else if position == .last {
                path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 10, height:  10))
            } else {
                path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight, .topLeft, .topRight],
                                    cornerRadii: CGSize(width: 0, height:  0))
            }
            
            shadowLayer.path = path.cgPath
            
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            shadowLayer.shadowOpacity = 0.15
            shadowLayer.shadowRadius = 10
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
}


enum SettingsCellPosition {
    case first
    case middle
    case last
}

enum SettingsCellType {
    case onOff
    case segue
    case link
}


