//
//  RoundShadowView.swift
//  LTios
//
//  Created by Paul Bénéteau on 19/08/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {
    
    /// The corner radius of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            self.updateProperties()
        }
    }
    /// The shadow color of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            self.updateProperties()
        }
    }
    /// The shadow offset of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 10) {
        didSet {
            self.updateProperties()
        }
    }
    /// The shadow radius of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            self.updateProperties()
        }
    }
    /// The shadow opacity of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowOpacity: Float = 0.06 {
        didSet {
            self.updateProperties()
        }
    }
    
    /**
     Masks the layer to it's bounds and updates the layer properties and shadow path.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        
        self.updateProperties()
        self.updateShadowPath()
    }
    
    /**
     Updates all layer properties according to the public properties of the `ShadowView`.
     */
    fileprivate func updateProperties() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOpacity = self.shadowOpacity
    }
    
    /**
     Updates the bezier path of the shadow to be the same as the layer's bounds, taking the layer's corner radius into account.
     */
    fileprivate func updateShadowPath() {
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    /**
     Updates the shadow path everytime the views frame changes.
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateProperties()
        self.updateShadowPath()
    }
}

class RoundShadowImageView: RoundView {
    
    var imageView = RoundImageView()
    
    var image: UIImage!  {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        needsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(imageView)
        needsUpdateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: frame.height / 2.0).cgPath
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(self)
            make.center.equalTo(self)
        }
    }
}

class RoundImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.height / 2.0
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

class RoundView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.height / 2.0
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
