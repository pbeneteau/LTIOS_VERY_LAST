//
//  MenuHomeView.swift
//  LTios
//
//  Created by Paul Bénéteau on 16/08/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit

class MenuHomeButtonView: UIView {
    
    private var constraintsAdded = false
    
    var circle1 = MenuHomeButtonCircleView()
    var circle2 = MenuHomeButtonCircleView()
    var circle3 = MenuHomeButtonCircleView()
    
    private var sizes: [CGFloat] = [CGFloat(0.52), CGFloat(0.42), CGFloat(0.38)] // big - medium - small
    private var circlesCenters = [CGPoint]()
    private var decreaseFactor: CGFloat = 0.55
    
    var isAnimating = false
    var shouldStopAnimation = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        backgroundColor = .clear
        initCircles()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        initCircles()
    }
    
    
    func initCircles() {
        
        self.addSubview(circle1)
        self.addSubview(circle2)
        self.addSubview(circle3)
    }
    
    override func layoutSubviews() {
        if !constraintsAdded || !isAnimating {
            addConstraints()
        } else {
            
        }
    }
    
    func updateCirclesColor(color: UIColor) {
        circle1.backgroundColor = color
        circle2.backgroundColor = color
        circle3.backgroundColor = color
    }
    
    func addConstraints() {
        
        let viewHeight = self.frame.size.height
        
        circle1.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * sizes[0])
            make.leftMargin.topMargin.equalTo(0)
        }
        
        circle2.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * sizes[1])
            make.rightMargin.equalTo(0)
            make.centerY.equalTo(self).inset(-viewHeight * 0.02)
        }
        
        circle3.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * sizes[2])
            make.bottom.equalTo(self)
            make.centerX.equalTo(self).inset(-viewHeight * 0.09)
        }
        
        constraintsAdded = true
    }
    
    func setCirclesCenters() {
        circlesCenters = [circle1.center, circle2.center, circle3.center]
    }
    
    func startAnimation() {
        isAnimating = true
        decreaseCirclesSizeAnimation(withDuration: 0.4) { end in
            self.animattionCycles()
        }
    }
    
    func animattionCycles() {
        
        self.moveCirclesAnimation(withDuration: 1) { end in
            
            self.updateSmallCirclesConstraints()
            
            if self.shouldStopAnimation {
                self.increaseCirclesSizeAnimation(withDuration: 0.4) { end in
                    self.shouldStopAnimation = false
                    self.isAnimating = false
                    return
                }
            } else {
                self.animattionCycles()
            }
        }
    }
    
    func updateSmallCirclesConstraints() {
        
        let viewHeight = self.frame.size.height
        let factor: CGFloat = decreaseFactor
        var center = CGPoint()
        
        center = circlesCenters[0]
        circle1.snp.updateConstraints { (make) -> Void in
            make.width.height.equalTo(viewHeight * (sizes[0] * factor))
            make.center.equalTo(center)
        }
        
        center = circlesCenters[1]
        circle2.snp.updateConstraints { (make) -> Void in
            make.width.height.equalTo(viewHeight * (sizes[1] * factor))
            make.center.equalTo(center)
        }
        
        center = circlesCenters[2]
        circle3.snp.updateConstraints { (make) -> Void in
            make.width.height.equalTo(viewHeight * (sizes[2] * factor))
            make.center.equalTo(center)
        }
        
        self.superview?.layoutIfNeeded()
        
    }
    
    func stopAnimation() {
        shouldStopAnimation = true
    }
    
    func decreaseCirclesSizeAnimation(withDuration: TimeInterval, completion: @escaping(Bool) -> Void) {
        
        let viewHeight = self.frame.size.height
        let factor: CGFloat = decreaseFactor
        var center = CGPoint()
        
        center = circlesCenters[0]
        circle1.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * (sizes[0] * factor))
            make.center.equalTo(center)
        }
        
        center = circlesCenters[1]
        circle2.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * (sizes[1] * factor))
            make.center.equalTo(center)
        }
        
        center = circlesCenters[2]
        circle3.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * (sizes[2] * factor))
            make.center.equalTo(center)
        }
        
        UIView.animate(withDuration: withDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.superview?.layoutIfNeeded()
        }, completion: { end in
            completion(true)
        })
    }
    
    func moveCirclesAnimation(withDuration: TimeInterval, completion: @escaping(Bool) -> Void) {
        
        let factor: CGFloat = decreaseFactor
        let viewHeight = self.frame.size.height
        var center = CGPoint()
        
        center = self.circlesCenters[1]
        circle1.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * sizes[1] * factor)
            make.center.equalTo(center)
        }
        
        center = self.circlesCenters[2]
        circle2.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * sizes[2] * factor)
            make.center.equalTo(center)
        }
        
        center = self.circlesCenters[0]
        circle3.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * sizes[0] * factor)
            make.center.equalTo(center)
        }
        
        UIView.animate(withDuration: (withDuration), animations: {
            self.superview?.layoutIfNeeded()
        }, completion: { end in
            completion(true)
        })
    }
    
    
    func increaseCirclesSizeAnimation(withDuration: TimeInterval, completion: @escaping(Bool) -> Void) {
        
        let viewHeight = self.frame.size.height
        var center = CGPoint()
        
        center = circlesCenters[1]
        circle1.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * (sizes[1]))
            make.center.equalTo(center)
        }
        
        center = circlesCenters[2]
        circle2.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * (sizes[2]))
            make.center.equalTo(center)
        }
        
        center = circlesCenters[0]
        circle3.snp.remakeConstraints { (make) -> Void in
            make.height.width.equalTo(viewHeight * (sizes[0]))
            make.center.equalTo(center)
        }
        
        UIView.animate(withDuration: withDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.superview?.layoutIfNeeded()
        }, completion: { end in
            completion(true)
        })
    }
    
}

class MenuHomeButtonCircleView: UIView {
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}
