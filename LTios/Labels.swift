//
//  Labels.swift
//  LTios
//
//  Created by Paul Bénéteau on 04/10/2017.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        textAlignment = .center
        font = LTFont.Menu.title
    }
}

class DescriptionLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        textAlignment = .center
        font = LTFont.regular.text
        numberOfLines = 10
    }
}

class NameLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        textAlignment = .justified
        font = LTFont.regular.bigText
    }
}

class errorTitleLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        textColor = UIColor.white
        textAlignment = .center
        font = UIFont(name: "Roboto-Medium", size: 27)
    }
}

class errorLabelLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        textColor = UIColor.white
        textAlignment = .center
        font = UIFont(name: "Roboto-Regular", size: 23)
        alpha = 0.8
        lineBreakMode = .byWordWrapping
        numberOfLines = 2
    }
}
