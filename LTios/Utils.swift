//
//  Utils.swift
//  LT_Contacts_Manager
//
//  Created by Paul Bénéteau on 31/07/2018.
//  Copyright © 2018 Paul Bénéteau. All rights reserved.
//

import Foundation
import UIKit

class AsyncOperation {
    
    typealias NumberOfPendingActions = Int
    typealias DispatchQueueOfReturningValue = DispatchQueue
    typealias CompleteClosure = ()->()
    
    private let dispatchQueue: DispatchQueue
    private var semaphore: DispatchSemaphore
    
    private var numberOfPendingActionsQueue: DispatchQueue
    public private(set) var numberOfPendingActions = 0
    
    var whenCompleteAll: (()->())?
    
    init(numberOfSimultaneousActions: Int, dispatchQueueLabel: String) {
        dispatchQueue = DispatchQueue(label: dispatchQueueLabel)
        semaphore = DispatchSemaphore(value: numberOfSimultaneousActions)
        numberOfPendingActionsQueue = DispatchQueue(label: dispatchQueueLabel + "_numberOfPendingActionsQueue")
    }
    
    func run(closure: @escaping (@escaping CompleteClosure)->()) {
        
        self.numberOfPendingActionsQueue.sync {
            self.numberOfPendingActions += 1
        }
        
        dispatchQueue.async {
            self.semaphore.wait()
            closure {
                self.numberOfPendingActionsQueue.sync {
                    self.numberOfPendingActions -= 1
                    if self.numberOfPendingActions == 0 {
                        self.whenCompleteAll?()
                    }
                }
                self.semaphore.signal()
            }
        }
    }
}

class SerialOperationQueue: OperationQueue {
    override init()
    {
        super.init()
        maxConcurrentOperationCount = 1
    }
}

class CustomNavigationController: UINavigationController {
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }
    
}

final class ForceTouchGestureRecognizer: UIGestureRecognizer {
    
    private let threshold: CGFloat = 0.75
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            handleTouch(touch)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            handleTouch(touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = UIGestureRecognizer.State.failed
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        state = UIGestureRecognizer.State.failed
    }
    
    private func handleTouch(_ touch: UITouch) {
        guard touch.force != 0 && touch.maximumPossibleForce != 0 else { return }
        
        if touch.force / touch.maximumPossibleForce >= threshold {
            state = UIGestureRecognizer.State.recognized
        }
    }
}


extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 15, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 40, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
