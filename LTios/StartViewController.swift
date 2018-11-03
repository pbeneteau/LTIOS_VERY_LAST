//
//  WelcomeViewController.swift
//  LTios
//
//  Created by Antoine Beneteau on 02/11/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit
import FirebaseAuth
import SnapKit

class StartViewController: ModalViewViewController {
    
    var didSetupConstraints = false
    var worldIsAnimating = false
    
    let bg = UIImageView(image: #imageLiteral(resourceName: "RegisterationBG"))
    let world = UIImageView(image: #imageLiteral(resourceName: "World"))
    let logo = LogoTitle()
    let slogan = Slogan()
    let startButton = StartButton()
    let startText = StartLabel()
    let loginButton = LoginButton()
    let signupButton = SignupButton()
    let termsButton = TermsButton()
    
    
    // LOGIN
    let loginBackButton = BackButton()
    let loginDescriptionLabel = LoginFormLabel()
    let loginEmailTextField = EmailTextField()
    let loginPasswordTextField = PasswordTextField()
    let loginFormButton = LoginFormButton()
    
    // SIGNUP
    var formHeight: CGFloat = 0.0
    let signupBackButton = BackButton()
    let signupDescriptionLabel = RegisterFormLabel()
    let signupFormView = RegisterForm()
    let separators = [UIImageView(image: #imageLiteral(resourceName: "Separator")),UIImageView(image: #imageLiteral(resourceName: "Separator")),UIImageView(image: #imageLiteral(resourceName: "Separator")),UIImageView(image: #imageLiteral(resourceName: "Separator"))]
    let signupFormButton = RegisterButton()
    let signupFormagreementsLabel = RegisterAgreementsLabel()
    let signupEmailTextField = EmailRegisterTextField()
    let signupPseudoTextField = PseudoRegisterTextField()
    let signupPasswordTextField = PasswordRegisterTextField()
    let signupPasswordConfTextField = PasswordRegisterTextField()
    let signupNameTextField = NameRegisterTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try  Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        
        view.addSubview(bg)
        view.addSubview(world)
        view.addSubview(logo)
        view.addSubview(slogan)
        view.addSubview(startButton)
        view.addSubview(startText)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        view.addSubview(termsButton)
        
        // LOGIN
        view.addSubview(loginBackButton)
        view.addSubview(loginDescriptionLabel)
        view.addSubview(loginEmailTextField)
        view.addSubview(loginPasswordTextField)
        view.addSubview(loginFormButton)
        
        // SIGNUP
        formHeight = view.frame.height * CGFloat(0.3421052632)
        view.addSubview(signupBackButton)
        view.addSubview(signupDescriptionLabel)
        view.addSubview(signupFormView)
        for separator in separators {
            view.addSubview(separator)
        }
        view.addSubview(signupFormButton)
        view.addSubview(signupFormagreementsLabel)
        view.addSubview(signupEmailTextField)
        view.addSubview(signupPseudoTextField)
        view.addSubview(signupPasswordTextField)
        view.addSubview(signupPasswordConfTextField)
        view.addSubview(signupNameTextField)
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(termsButtonPressed), for: .touchUpInside)
        signupBackButton.addTarget(self, action: #selector(signupBackButtonPressed), for: .touchUpInside)
        loginBackButton.addTarget(self, action: #selector(loginBackButtonPressed), for: .touchUpInside)
        loginFormButton.addTarget(self, action: #selector(loginFormButtonPressed), for: .touchUpInside)
        
        self.view.setNeedsUpdateConstraints()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if !worldIsAnimating {
            animateWorld()
            worldIsAnimating = true
        }
    }
    
    
    private func animateWorld() {
        
        UIView.animate(withDuration: 500, delay: 0, options: [.repeat, .curveLinear], animations: { () -> Void in
            self.world.snp.updateConstraints { make in
                make.left.equalTo(self.view.snp.left).offset(-self.world.frame.width)
            }
            self.world.superview?.layoutIfNeeded()
        })
    }
    
    @objc func startButtonPressed() {
        hideStartButton()
        putLogoUp(n:0.15)
        showLoginAndRegisterState()
    }
    
    @objc func loginButtonPressed() {
        hideLoginAndRegister()
        showLogin()
    }
    
    @objc func signupButtonPressed() {
        hideLoginAndRegister()
        putLogoUp(n:0.1)
        showRegister()
    }
    
    @objc func termsButtonPressed() {
    }
    
    @objc func signupBackButtonPressed() {
        hideRegister()
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.showLoginAndRegisterState()
        }
    }
    
    @objc func loginBackButtonPressed() {
        hideLogin()
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.showLoginAndRegisterState()
        }
    }
    
    @objc func loginFormButtonPressed() {
        let email = "inesbenett@hotmail.fr"
        let password = "combava"
        
        // [START headless_email_auth]
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            // [START_EXCLUDE]
            
            if let error = error {
                print(error.localizedDescription)
            }
            else if let user = authResult?.user {
                //DatabaseService.shared.createNewUserInDatabase(uid: user.uid, firstname: firstname, lastname: lastname)
                let vc = MenuViewController()
                self.present(vc, animated: true, completion: nil)
            }
            // [END_EXCLUDE]
        }
        // [END headless_email_auth]
    }
    
    @objc func signupFormButtonPressed() {
    }
    
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}


//MARK: Constraints
extension StartViewController {
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            
            bg.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(view.snp.width)
                make.height.equalTo(view.snp.height)
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY)
            }
            
            world.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(view.snp.top)
                make.left.equalTo(view.snp.left)
            }
            
            logo.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(view.snp.bottom).multipliedBy(0.25)
                make.centerX.equalTo(view.snp.centerX)
            }
            
            slogan.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(logo.snp.bottom).offset(5)
                make.centerX.equalTo(view.snp.centerX)
            }
            
            startButton.snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(view.snp.centerY)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(182)
                make.height.equalTo(56)
            }
            
            startText.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(view.snp.bottom).multipliedBy(1.1)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(view.snp.width).multipliedBy(0.75)
            }
            
            loginButton.snp.remakeConstraints { make in
                make.top.equalTo(startText.snp.bottom).offset(25)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(240)
                make.height.equalTo(44)
            }
            
            signupButton.snp.remakeConstraints { make in
                make.top.equalTo(loginButton.snp.bottom).offset(15)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(240)
                make.height.equalTo(44)
            }
            
            termsButton.snp.remakeConstraints { make in
                make.top.equalTo(signupButton.snp.bottom).offset(7)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(loginButton.snp.width)
            }
            
            
            // ####### LOGIN #########
            loginDescriptionLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(view.snp.bottom).multipliedBy(1.1)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(view.snp.width).multipliedBy(0.875)
            }
            
            loginEmailTextField.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(loginDescriptionLabel.snp.bottom).offset(20)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(view.snp.width).multipliedBy(0.875)
                make.height.equalTo(50)
            }
            
            loginPasswordTextField.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(loginEmailTextField.snp.bottom).offset(5)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(view.snp.width).multipliedBy(0.875)
                make.height.equalTo(50)
            }
            
            loginFormButton.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(loginPasswordTextField.snp.bottom).offset(15)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(view.snp.width).multipliedBy(0.875)
                make.height.equalTo(55)
            }
            
            loginBackButton.snp.remakeConstraints { make in
                make.centerY.equalTo(loginDescriptionLabel.snp.centerY)
                make.left.equalTo(loginPasswordTextField.snp.left).offset(3)
                make.width.equalTo(26)
                make.height.equalTo(22)
            }
            
            // ####### SIGNUP ########
            signupDescriptionLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(view.snp.bottom).multipliedBy(1.1)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(view.snp.width).multipliedBy(0.75)
            }
            
            if UIScreen.main.bounds.size.width <= 414 {
                signupFormView.snp.makeConstraints { (make) -> Void in
                    make.top.equalTo(signupDescriptionLabel.snp.bottom).offset(10)
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.equalTo(view.snp.width).multipliedBy(0.875)
                    make.height.equalTo(view.snp.height).multipliedBy(0.3421052632)
                }
            } else {
                formHeight = 251.66
                signupFormView.snp.makeConstraints { (make) -> Void in
                    make.top.equalTo(signupDescriptionLabel.snp.bottom).offset(15)
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.equalTo(362)
                    make.height.equalTo(251.66)
                }
            }
            
            var i : CGFloat = 1
            for separator in separators {
                separator.snp.makeConstraints { (make) -> Void in
                    make.centerY.equalTo(signupFormView.snp.top).offset(i * formHeight / 5)
                    make.left.equalTo(signupFormView.snp.left)
                    make.right.equalTo(signupFormView.snp.right)
                }
                i += 1
            }
            separators[0].snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(signupFormView.snp.top).offset(formHeight / 5)
                make.left.equalTo(signupFormView.snp.left)
                make.right.equalTo(signupFormView.snp.right)
            }
            signupBackButton.snp.remakeConstraints { make in
                make.centerY.equalTo(signupDescriptionLabel.snp.centerY)
                make.left.equalTo(signupFormView.snp.left).offset(3)
                make.width.equalTo(26)
                make.height.equalTo(22)
            }
            signupFormButton.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(signupFormView.snp.bottom).offset(17)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(signupFormView.snp.width)
                make.height.equalTo(56)
            }
            signupFormagreementsLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(signupFormButton.snp.bottom).offset(8)
                make.centerX.equalTo(signupFormButton.snp.centerX)
            }
            signupEmailTextField.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(signupFormView.snp.top)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(signupFormView.snp.width)
                make.height.equalTo(formHeight / 5)
            }
            signupPseudoTextField.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(signupEmailTextField.snp.top).offset(formHeight / 5)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(signupFormView.snp.width)
                make.height.equalTo(formHeight / 5)
            }
            signupPasswordTextField.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(signupPseudoTextField.snp.top).offset(formHeight / 5)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(signupFormView.snp.width)
                make.height.equalTo(formHeight / 5)
            }
            
            signupPasswordConfTextField.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(signupPasswordTextField.snp.top).offset(formHeight / 5)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(signupFormView.snp.width)
                make.height.equalTo(formHeight / 5)
            }
            
            signupNameTextField.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(signupPasswordConfTextField.snp.top).offset(formHeight / 5)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(signupFormView.snp.width)
                make.height.equalTo(formHeight / 5)
            }
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}


// ####### ANIMATIONS #######
extension StartViewController {
    
    private func hideStartButton() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
            self.startButton.alpha = 0.0
            self.startButton.isEnabled = false
        })
    }
    
    private func putLogoUp(n: Double) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
            self.logo.snp.remakeConstraints { make in
                make.top.equalTo(self.view.snp.bottom).multipliedBy(n)
                make.centerX.equalTo(self.view.snp.centerX)
            }
            self.startText.superview?.layoutIfNeeded()
        })
    }
    private func showLoginAndRegisterState() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
            self.startText.snp.remakeConstraints { make in
                make.top.equalTo(self.view.snp.bottom).multipliedBy(0.40)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.75)
            }
            self.startText.superview?.layoutIfNeeded()
        })
    }
    
    private func hideLoginAndRegister() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
            self.startText.snp.remakeConstraints { make in
                make.top.equalTo(self.view.snp.bottom).multipliedBy(1.2)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.75)
            }
            self.startText.superview?.layoutIfNeeded()
        })
    }
    
    private func showLogin() {
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
                self.loginDescriptionLabel.snp.remakeConstraints { (make) -> Void in
                    make.top.equalTo(self.view.snp.bottom).multipliedBy(0.35)
                    make.centerX.equalTo(self.view.snp.centerX)
                    make.width.equalTo(self.view.snp.width).multipliedBy(0.875)
                }
                self.loginDescriptionLabel.superview?.layoutIfNeeded()
            })
        }
    }
    
    private func hideLogin() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
            self.loginDescriptionLabel.snp.remakeConstraints { (make) -> Void in
                make.top.equalTo(self.view.snp.bottom).multipliedBy(1.1)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.875)
            }
            self.loginDescriptionLabel.superview?.layoutIfNeeded()
        })
    }
    
    private func showRegister() {
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
                self.signupDescriptionLabel.snp.remakeConstraints { make in
                    make.top.equalTo(self.view.snp.bottom).multipliedBy(0.20)
                    make.centerX.equalTo(self.view.snp.centerX)
                    make.width.equalTo(240)
                    make.height.equalTo(44)
                }
                self.signupDescriptionLabel.superview?.layoutIfNeeded()
            })
        }
    }
    
    private func hideRegister() {
        putLogoUp(n:0.15)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
            self.signupDescriptionLabel.snp.remakeConstraints { make in
                make.top.equalTo(self.view.snp.bottom).multipliedBy(1.2)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(240)
                make.height.equalTo(44)
            }
            self.signupDescriptionLabel.superview?.layoutIfNeeded()
        })
    }
    
}

