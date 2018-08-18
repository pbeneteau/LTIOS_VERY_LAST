//
//  ScannerNode.swift
//  LTios
//
//  Created by antoine beneteau on 2017-08-20.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import SpriteKit



private struct Stack<U> {
  typealias T = (stack: [[U]], current: [U])
  private var value: T
  var values: [[U]] {
    return value.stack + [value.current]
  }
  init() {
    self.value = (stack: [], current: [])
  }
  mutating func add(toStack element: U) {
    self.value = (stack: value.stack + [value.current], current: [element])
  }
  mutating func add(toCurrent element: U) {
    self.value = (stack: value.stack, current: value.current + [element])
  }
}

private func +=(lhs: inout String?, rhs: String) {
  lhs = (lhs ?? "") + rhs
}


class Node: MaskNode {
  
  private var interestingUser: InterestingUser!
  
  public lazy var sprite: SKSpriteNode = { [unowned self] in
    let sprite = SKSpriteNode()
    sprite.size = self.frame.size
    sprite.colorBlendFactor = 0.0
    self.mask.addChild(sprite)
    return sprite
    }()
  

  open var image: UIImage? {
    didSet {
      texture = image.map { SKTexture(image: $0) }
    }
  }
  
  override open var strokeColor: UIColor {
    didSet {
      maskOverlay.strokeColor = strokeColor
    }
  }
  
  private(set) var texture: SKTexture?
  

  open var isSelected: Bool = false {
    didSet {
      guard isSelected != oldValue else { return }
      if isSelected {
        selectedAnimation()
      } else {
        deselectedAnimation()
      }
    }
  }
  
  public init(image: UIImage?, radius: CGFloat, interestingUser: InterestingUser) {
    super.init(circleOfRadius: radius)
    
    self.physicsBody = {
      let body = SKPhysicsBody(circleOfRadius: radius + 2)
      body.allowsRotation = false
      body.friction = 0
      body.linearDamping = 3
      return body
    }()
    self.fillColor = .clear
    self.strokeColor = .clear

    configure(image: image, interestingUser: interestingUser)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open func configure(image: UIImage?, interestingUser: InterestingUser) {
    self.interestingUser = interestingUser
    self.image = image
    sprite.run(.setTexture(SKTexture(imageNamed: "defaultNearbyIcon")))

  }
  
  override open func removeFromParent() {
    removedAnimation() {
      super.removeFromParent()
    }
  }
  

  open func selectedAnimation() {
    run(.scale(to: 4/3, duration: 0.2))
    if let img = image {
      sprite.run(.setTexture(SKTexture(image: img)))
    }
  }
  

  open func deselectedAnimation() {
    run(.scale(to: 1, duration: 0.2))
    sprite.run(.setTexture(SKTexture(imageNamed: "defaultNearbyIcon")))
  }
  
  open func removedAnimation(completion: @escaping () -> Void) {
    run(.fadeOut(withDuration: 0.2), completion: completion)
  }
  
  public func getInterestingUser() -> InterestingUser {
    return interestingUser
  }
  
}

open class MaskNode: SKShapeNode {
  
  let mask: SKCropNode
  let maskOverlay: SKShapeNode
  
  public init(circleOfRadius radius: CGFloat) {
    mask = SKCropNode()
    mask.maskNode = {
      let node = SKShapeNode(circleOfRadius: radius)
      node.fillColor = .white
      node.strokeColor = .clear
      return node
    }()
    
    maskOverlay = SKShapeNode(circleOfRadius: radius)
    maskOverlay.fillColor = .clear
    
    super.init()
    self.path = maskOverlay.path
    
    self.addChild(mask)
    self.addChild(maskOverlay)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
