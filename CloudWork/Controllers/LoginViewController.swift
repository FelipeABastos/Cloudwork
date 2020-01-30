//
//  LoginScreenController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 11/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import RKDropdownAlert

class LoginViewController: UIViewController {
    
    var alreadyAnimatedForm: Bool = false
    
    @IBOutlet var btnSignIn: UIButton?
    @IBOutlet var btnRegister: UIButton?
    @IBOutlet var btnForgotPassword: UIButton?
    
    @IBOutlet var txtEmail: UITextField?
    @IBOutlet var txtPassword: UITextField?
    
    @IBOutlet var vwLogo: UIView?
    @IBOutlet var vwUnderlineEmail: UIView?
    @IBOutlet var vwUnderlinePassword: UIView?
    @IBOutlet var vwCloud: UIView?
    
    let defaults = UserDefaults.standard
    
    //-----------------------------------------------------------------------
    //  MARK: - UIViewController
    //-----------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fieldEmail = txtEmail {
            Util.tintPlaceholder(field: fieldEmail, color: .white)
        }

        if let fieldPassword = txtPassword {
            Util.tintPlaceholder(field: fieldPassword, color: .white)
        }
        
        #if DEBUG
        self.txtEmail?.text = "felipe.bastos3357@gmail.com"
        self.txtPassword?.text = "123456"
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if alreadyAnimatedForm == false {
            self.animateForms()
            alreadyAnimatedForm = true
        }
        self.animateCloud()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Session.get() != nil {
            self.showHome()
        }else{
            self.showForm()
        }
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - Private Functions
    //-----------------------------------------------------------------------
    
    @IBAction private func validateLogin() {
        
        if let login = self.validateEmail(), let password = self.validatePassword() {
            
            self.makeLogin(email: login, password: password)
        }
    }
    
    private func validatePassword() -> String? {
        
        if let textPassword = txtPassword?.text, textPassword.isEmpty != true {
            //Password validated
            return textPassword
        }else{
            self.vwUnderlinePassword?.backgroundColor = UIColor.red
            
            Util.showMessage(text: "You need to put your password.", type: .warning)
            return nil
        }
    }
    
    private func validateEmail() -> String? {
        
        if let textEmail = self.txtEmail?.text, textEmail.isEmpty != true {
            
            if Util.validate(email: textEmail) {
                //Email validated
                 return textEmail
            }else{
                //Email invalid
                Util.showMessage(text: "Fill the text field with a valid email.", type: .warning)
                return nil
            }
        }else{
            //Email field is empty
            Util.showMessage(text: "Fill the text field with an email.", type: .warning)
            return nil
        }
    }
    
    private func makeLogin(email: String, password: String) {
        
        let parameters = ["email": email,
                          "password": password] as [String : String]
        
        RequestManager.login(parameters: parameters) { (result) in
            if result == true {
                
                self.showHome()
                Util.showMessage(text: "Successfully authenticated", type: .success)
            }else{
                self.vwUnderlineEmail?.backgroundColor = UIColor.red
                self.vwUnderlinePassword?.backgroundColor = UIColor.red
                
                Util.showMessage(text: "User didn't found", type: .warning)
            }
        }
    }
        
    private func showHome() {

        let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeView") as! HomeViewController
        
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.isNavigationBarHidden = true
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    //---------------------------------------------------------------------------------------------
    //  MARK: - Animations
    //---------------------------------------------------------------------------------------------
    
    private func animateCloud() {
    let options: UIView.AnimationOptions = [.curveEaseInOut,
                                            .repeat,
                                            .autoreverse]
        
        UIView.animate(withDuration: 2.0, delay: 0,
                       options: options,
                       animations: {[weak self] in
                        self?.vwCloud?.frame.size.height *= 0.90
                        self?.vwCloud?.frame.size.height *= 0.90
        }, completion: nil)
    }
    
    private func animateForms() {
        
        self.hideForm()
        
        UIView.animate(withDuration: 2.0, delay: 0,
                           options: [],
                           animations: {[weak self] in
                            self?.vwLogo?.frame.size.height *= 1.08
                            self?.vwLogo?.frame.size.width *= 1.08
            }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0,
                       options: [],
                       animations: {[weak self] in
                        self?.txtEmail?.frame.size.height *= 1.08
                        self?.txtEmail?.frame.size.width *= 1.08
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0,
                       options: [],
                       animations: {[weak self] in
                        self?.vwUnderlineEmail?.frame.size.height *= 1.08
                        self?.vwUnderlineEmail?.frame.size.width *= 1.08
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0,
                       options: [],
                       animations: {[weak self] in
                        self?.txtPassword?.frame.size.height *= 1.08
                        self?.txtPassword?.frame.size.width *= 1.08
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0,
                       options: [],
                       animations: {[weak self] in
                        self?.vwUnderlinePassword?.frame.size.height *= 1.08
                        self?.vwUnderlinePassword?.frame.size.width *= 1.08
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0,
                       options: [],
                       animations: {[weak self] in
                        self?.btnSignIn?.frame.size.height *= 1.08
                        self?.btnSignIn?.frame.size.width *= 1.08
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0,
                       options: [],
                       animations: {[weak self] in
                        self?.btnRegister?.frame.size.height *= 1.08
                        self?.btnRegister?.frame.size.width *= 1.08
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0,
                       options: [],
                       animations: {[weak self] in
                        self?.btnForgotPassword?.frame.size.height *= 1.08
                        self?.btnForgotPassword?.frame.size.width *= 1.08
        }, completion: nil)
    }
    
    private func showForm(){
        
        UIView.animate(withDuration: 1.5, animations: {
            self.vwLogo?.alpha = 1
            self.txtEmail?.alpha = 1
            self.vwUnderlineEmail?.alpha = 1
            self.txtPassword?.alpha = 1
            self.vwUnderlinePassword?.alpha = 1
            self.btnSignIn?.alpha = 1
            self.btnRegister?.alpha = 1
            self.btnForgotPassword?.alpha = 1
        })
    }
    
    private func hideForm() {
        
        self.vwLogo?.alpha = 0
        self.txtEmail?.alpha = 0
        self.vwUnderlineEmail?.alpha = 0
        self.txtPassword?.alpha = 0
        self.vwUnderlinePassword?.alpha = 0
        self.btnSignIn?.alpha = 0
        self.btnRegister?.alpha = 0
        self.btnForgotPassword?.alpha = 0
    }
    
    private func stayLogged (){
        defaults.set(true, forKey: Constants.Key.authenticated)
    }
}
