//
//  Registering.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-31.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit
import PhoneNumberKit
import SnapKit


// MARK: - Phone Verification


class LogoTitle: UILabel {
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
        text = "Little World"
        font = UIFont(name: "Roboto-Medium", size: 36)
        textColor = .white
        textAlignment = .center
        minimumScaleFactor = 0.5
    }
}

class Slogan: UILabel {
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
        text = "Connect the world"
        font = UIFont(name: "Roboto-Light", size: 16)
        textColor = .white
        textAlignment = .center
    }
}

class StartButton: UIButton {
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
        setImage(UIImage(named: "welcomeButton"), for: .normal)
    }
}

class StartLabel: UILabel {
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
        text = "To be able to use LittleWorld, you need to have an account"
        font = UIFont(name: "Roboto-Light", size: 14)
        textColor = .white
        textAlignment = .center
        numberOfLines = 2
    }
}

class SignupButton: UIButton {
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
        setImage(#imageLiteral(resourceName: "Signupbutton"), for: .normal)
    }
}

class LoginButton: UIButton {
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
        setImage(#imageLiteral(resourceName: "loginButton"), for: .normal)
    }
}

class TermsButton: UIButton {
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
        setTitle("Terms and conditions",for: .normal)
        titleLabel?.font = UIFont(name: "Roboto-Light", size: 12)
        titleLabel?.textColor = .white
        titleLabel?.numberOfLines = 2
    }
}

class CountryButton: UIButton {
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
        setImage(#imageLiteral(resourceName: "FR"), for: .normal)
    }
}


class PhoneTextField: PhoneNumberTextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .white
        font = UIFont(name: "Roboto-Regular", size: 20)
        borderStyle = .none
        keyboardType = .phonePad
        keyboardAppearance = .light
        returnKeyType = .go
        autocorrectionType = .no
        isPartialFormatterEnabled = false
    }
}

class PhonePlaceHolder: UILabel {
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
        text = " Enter your phone number"
        font = UIFont(name: "Roboto-Light", size: 16)
        textColor = .white
        textAlignment = .center
        minimumScaleFactor = 0.2
        adjustsFontSizeToFitWidth = true
    }
}

class PhoneTextFieldLine: UIImageView {
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
        image = #imageLiteral(resourceName: "PhoneTextFieldLine")
    }
}

class RegistrationNextButton: UIButton {
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
        setImage(#imageLiteral(resourceName: "nextRegButton"), for: .normal)
        alpha = 0.0
    }
}
