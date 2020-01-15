//
//  LoginScreenController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 11/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

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
    
    struct Keys {
        static let userEmail = "user_email"
        static let userPassword = "user_password"
        static let authenticated = "authenticated"
    }
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fieldEmail = txtEmail {
            Util.tintPlaceholder(field: fieldEmail, color: .white)
        }

        if let fieldPassword = txtPassword {
            Util.tintPlaceholder(field: fieldPassword, color: .white)
        }
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
        
            //-----------------------------------------
            //  Debug how many users you have
            //-----------------------------------------
            
            let array = PersistManager.get()
            for item in array {
                print(item[Constants.Key.userEmail]!)
            }
            print("You have \(array.count) registered users.")
        }
    
    //-----------------------------------------------------------------------
    //    MARK: Private Functions
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
            self.passwordIsEmpty()
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
                self.emailFieldIncorrectlyFilled()
                return nil
            }
        }else{
            //Email field is empty
            self.emailFieldIsEmpty()
            return nil
        }
    }
    
    private func makeLogin(email: String, password: String) {
        
        let array = PersistManager.get()
        
        for user in array {
            
            if user[Constants.Key.userEmail] == email && user[Constants.Key.userPassword] == password {
                
                Session.set(data: user)
                
                self.showHome()
                
                return
            }
        }
        
        self.loginInvalid()
    }
    
    private func loginInvalid() {
        
        self.vwUnderlinePassword?.backgroundColor = UIColor.red
        self.vwUnderlineEmail?.backgroundColor = UIColor.red
        
        let alert = UIAlertController(title: "Error!",
                                      message: "Your email or password are invalid.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    private func emailFieldIncorrectlyFilled() {
        
        self.vwUnderlineEmail?.backgroundColor = UIColor.red
        
        let alert = UIAlertController(title: "Error!",
                                      message: "Fill the text field with a valid email.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true)
    }
    
    private func emailFieldIsEmpty() {
        
        self.vwUnderlineEmail?.backgroundColor = UIColor.red
        
        let alert = UIAlertController(title: "Error!",
                                      message: "Fill the text field with an email.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    private func passwordIsEmpty() {
        
        self.vwUnderlinePassword?.backgroundColor = UIColor.red
        
        let alert = UIAlertController(title: "Error!",
                                      message: "You need to put your password.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    private func showHome() {

        let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeView") as! HomeViewController
        self.present(homeVC, animated: true, completion: nil)
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
        defaults.set(true, forKey: Keys.authenticated)
    }
}
