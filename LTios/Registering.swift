//
//  Register.swift
//  LTios
//
//  Created by Antoine Beneteau on 02/11/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit
import PhoneNumberKit
import SnapKit


// MARK: - Registeration Form

class RegisterFormLabel: UILabel {
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
        text = "Fill the form to continue"
        font = UIFont(name: "Roboto-Light", size: 15)
        textColor = .white
        textAlignment = .center
        minimumScaleFactor = 0.5
    }
}

class RegisterForm: UIView {
    
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
    }
}

class EmailRegisterTextField: UITextField {
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
        returnKeyType = .next
        autocorrectionType = .no
        layer.borderWidth = 0.0
    }
}

class PseudoRegisterTextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        setIcon(UIImage(named: "pseudo")!)
        
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Roboto-Regular", size: 15)
        textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        borderStyle = .roundedRect
        keyboardType = .default
        keyboardAppearance = .light
        returnKeyType = .next
        autocorrectionType = .no
        layer.borderWidth = 0.0
        isSecureTextEntry = true
    }
}

class PasswordRegisterTextField: UITextField {
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
        keyboardType = .emailAddress
        keyboardAppearance = .light
        returnKeyType = .next
        autocorrectionType = .no
        layer.borderWidth = 0.0
        isSecureTextEntry = true
    }
}

class NameRegisterTextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        setIcon(UIImage(named: "name")!)
        
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Roboto-Regular", size: 15)
        textColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        borderStyle = .roundedRect
        keyboardType = .default
        keyboardAppearance = .light
        returnKeyType = .next
        autocorrectionType = .no
        layer.borderWidth = 0.0
    }
}

class RegisterButton: UIButton {
    
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
        let numberAsString = "SIGNUP"
        
        let attributes = [NSAttributedStringKey.font: UIFont(name: "Roboto-Regular", size: 15.0)!, NSAttributedStringKey.foregroundColor: UIColor.CustomColor.blue]
        
        setAttributedTitle(NSAttributedString(string: numberAsString, attributes: attributes), for: .normal)
        
    }
}

class RegisterAgreementsLabel: UILabel {
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
        text = "By clicking this button you agree our terms and conditions"
        font = UIFont(name: "Roboto-Light", size: 11)
        textColor = .white
        textAlignment = .center
        minimumScaleFactor = 0.5
    }
}

// MARK: - Import Contacts

class FirstContactLabel: UILabel {
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
        text = "Import your contacts"
        font = UIFont(name: "Roboto-Light", size: 20)
        textColor = .white
        textAlignment = .center
        minimumScaleFactor = 0.5
    }
}

class FirstImportButton: UIButton {
    
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
        layer.cornerRadius = 15
        clipsToBounds = true
        setBackgroundColor(color: UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0), forState: .highlighted)
        let numberAsString = "IMPORT"
        let attributes = [NSAttributedStringKey.font: UIFont(name: "Roboto-Regular", size: 15.0)!, NSAttributedStringKey.foregroundColor: UIColor.CustomColor.blue]
        
        setAttributedTitle(NSAttributedString(string: numberAsString, attributes: attributes), for: .normal)
    }
}

class FirstContactAgreementsLabel: UILabel {
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
        text = "You will be able to manage your contact list in your profile"
        font = UIFont(name: "Roboto-Light", size: 14)
        textColor = .white
        textAlignment = .center
        numberOfLines = 3
        minimumScaleFactor = 0.5
    }
}



