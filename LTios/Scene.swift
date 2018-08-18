//
//  Scene.swift
//  LTios
//
//  Created by antoine beneteau on 2017-08-20.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import SpriteKit

protocol MagneticDelegate: class {
  func magnetic(_ magnetic: Magnetic, didSelect node: Node)
  func magnetic(_ magnetic: Magnetic, didDeselect node: Node)
}

open class Magnetic: SKScene {
  
  /**
   The field node that accelerates the nodes.
   */
  public lazy var magneticField: SKFieldNode = { [unowned self] in
    let field = SKFieldNode.radialGravityField()
    field.region = SKRegion(radius: 2000)
    field.minimumRadius = 2000
    field.strength = 500
    self.addChild(field)
    return field
    }()
  
  /**
   Controls whether you can select multiple nodes.
   */
  open var allowsMultipleSelection: Bool = true
  
  var isMoving: Bool = false
  
  /**
   The selected children.
   */
  var selectedChildren: [Node] {
    return children.compactMap { $0 as? Node }.filter { $0.isSelected }
  }
  
  /**
   The object that acts as the delegate of the scene.
   
   The delegate must adopt the MagneticDelegate protocol. The delegate is not retained.
   */
  weak var magneticDelegate: MagneticDelegate?
  
  override open var size: CGSize {
    didSet {
      configPhysics()
    }
  }
  
  override public init(size: CGSize) {
    super.init(size: size)
    
    commonInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    commonInit()
  }
  
  func commonInit() {
    backgroundColor = .white
    scaleMode = .aspectFill
    configPhysics()
  }
  
  func configPhysics() {
    physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    physicsBody = SKPhysicsBody(edgeLoopFrom: { () -> CGRect in
      var frame = self.frame
      frame.size.width = CGFloat(magneticField.minimumRadius)
      frame.origin.x -= frame.size.width / 2
      return frame
    }())
    magneticField.position = CGPoint(x: size.width / 2, y: size.height / 2)
  }
  
  override open func addChild(_ node: SKNode) {
    var x = -node.frame.width
    if children.count % 2 == 0 {
      x = frame.width + node.frame.width
    }
    let y = CGFloat.random(node.frame.height, frame.height - node.frame.height)
    node.position = CGPoint(x: x, y: y)
    super.addChild(node)
  }
  
  override open func atPoint(_ p: CGPoint) -> SKNode {
    var node = super.atPoint(p)
    while true {
      if node is Node {
        return node
      } else if let parent = node.parent {
        node = parent
      } else {
        break
      }
    }
    return node
  }
  
}

extension Magnetic {
  
  
  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !isMoving, let point = touches.first?.location(in: self), let node = atPoint(point) as? Node {
      if node.isSelected {
        node.isSelected = false
        magneticDelegate?.magnetic(self, didDeselect: node)
      } else {
        if !allowsMultipleSelection, let selectedNode = selectedChildren.first {
          selectedNode.isSelected = false
          magneticDelegate?.magnetic(self, didDeselect: selectedNode)
        }
        node.isSelected = true
        magneticDelegate?.magnetic(self, didSelect: node)
      }
    }
    isMoving = false
  }
  
  override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    isMoving = false
  }
  
}

