//
//  File.swift
//  LTios
//
//  Created by Antoine Beneteau on 02/11/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit
import PhoneNumberKit
import SnapKit


// Mark: - Code Verification

class verificationCodeLabel: UILabel {
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
        text = "Enter the verification code"
        font = UIFont(name: "Roboto-Light", size: 20)
        textColor = .white
        textAlignment = .center
        minimumScaleFactor = 0.5
    }
}

class DigitTextField: UITextField {
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
        textColor = .white
        font = UIFont(name: "Roboto-Regular", size: 27)
        textColor = .white
        borderStyle = .none
        keyboardType = .phonePad
        keyboardAppearance = .light
        returnKeyType = .next
        autocorrectionType = .no
        textAlignment = .center
        resignFirstResponder()
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
}

class VerificationSuccessLabel: UILabel {
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
        text = "Success !"
        font = UIFont(name: "Roboto-Light", size: 14)
        textColor = .white
        textAlignment = .center
        minimumScaleFactor = 0.5
        alpha = 0.0
    }
}

class BackButton: UIButton {
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
        setImage(#imageLiteral(resourceName: "verificationBackArrow"), for: .normal)
    }
}
