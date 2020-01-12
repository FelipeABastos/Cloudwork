//
//  LoginScreenController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 11/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var btnSignIn: UIButton?
    @IBOutlet var btnRegister: UIButton?
    @IBOutlet var btnForgotPassword: UIButton?
    
    @IBOutlet var txtEmail: UITextField?
    @IBOutlet var txtPassword: UITextField?
    
    @IBOutlet var vwUnderlineEmail: UIView?
    @IBOutlet var vwUnderlinePassword: UIView?
    
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    @IBAction func validateLogin() {
        
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
        
        if email == "teste@gmail.com" && password == "123" {
            //Login Authenticated
            let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeView") as! HomeViewController
            
            self.present(homeVC, animated: true, completion: nil)
            
        }else{
            //Login Invalid
            self.loginInvalid()
        }
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
    
}
