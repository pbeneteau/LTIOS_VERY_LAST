//
//  Login.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-31.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit
import PhoneNumberKit
import SnapKit

// MARK: - Login Form

class LoginFormLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        text = "Enter your credentials"
        font = UIFont(name: "Roboto-Light", size: 15)
        textColor = .white
        textAlignment = .center
        minimumScaleFactor = 0.5
    }
}

class EmailTextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        
        setIcon(UIImage(named: "email")!)
        
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Roboto-Regular", size: 15)
        textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        borderStyle = .roundedRect
        keyboardType = .emailAddress
        keyboardAppearance = .light
        returnKeyType = .continue
        autocorrectionType = .no
    }
}

class PasswordTextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        setIcon(UIImage(named: "password")!)
        
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Roboto-Regular", size: 15)
        textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        borderStyle = .roundedRect
        keyboardType = .default
        keyboardAppearance = .light
        isSecureTextEntry = true
        returnKeyType = .continue
        autocorrectionType = .no
    }
}

class LoginFormButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 5
        clipsToBounds = true
        setBackgroundColor(color: UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0), forState: .highlighted)
        let numberAsString = "LOG IN"
        
        let attributes = [NSAttributedStringKey.font: UIFont(name: "Roboto-Regular", size: 15.0)!, NSAttributedStringKey.foregroundColor: UIColor.CustomColor.blue]
        
        setAttributedTitle(NSAttributedString(string: numberAsString, attributes: attributes), for: .normal)
        
    }
}
