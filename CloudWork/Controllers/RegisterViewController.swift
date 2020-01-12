//
//  RegisterViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 11/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var txtName: UITextField?
    @IBOutlet var txtEmail: UITextField?
    @IBOutlet var txtPasswordOne: UITextField?
    @IBOutlet var txtPasswordTwo: UITextField?
    
    @IBOutlet var vwUnderlineName: UIView?
    @IBOutlet var vwUnderlineEmailRegister: UIView?
    @IBOutlet var vwUnderlinePasswordOne: UIView?
    @IBOutlet var vwUnderlinePasswordTwo: UIView?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fieldName = txtName {
            Util.tintPlaceholder(field: fieldName, color: .white)
        }
        
        if let fieldEmail = txtEmail {
            Util.tintPlaceholder(field: fieldEmail, color: .white)
        }
        
        if let fieldPasswordOne = txtPasswordOne {
            Util.tintPlaceholder(field: fieldPasswordOne, color: .white)
        }
        if let fieldPasswordTwo = txtPasswordTwo {
            Util.tintPlaceholder(field: fieldPasswordTwo, color: .white)
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
    
    @IBAction func backToLogin() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registrationComplete() {
        
         if let text = self.txtEmail?.text, text.isEmpty != true {
                   
                   if Util.validate(email: text) {
                       //Email validated
                       //self.emailSent()
                   }else{
                       //Email invalid
                       self.emailFieldIncorrectlyFilled()
                   }
               }else{
                   //Field is Empty
                   self.emailFieldIsEmpty()
               }
        
        if self.txtPasswordOne?.text == self.txtPasswordTwo?.text {
            
            let alert = UIAlertController(title: "Registered successfully!", message: "Confirm your email to validate the account.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }else {
            
//            let alert = UIAlertController(title: "Error!", message: "Passwords must be the same.", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
//
//            self.present(alert, animated: true)
            
            passwordAreNotTheSame()
            passwordAreNotTheSameAlert()
        }
    }
    
    private func passwordAreNotTheSame() {
        
        if let fieldPasswordOne = txtPasswordOne {
            Util.tintPlaceholder(field: fieldPasswordOne, color: .red)
        }
        if let fieldPasswordTwo = txtPasswordTwo {
            Util.tintPlaceholder(field: fieldPasswordTwo, color: .red)
        }
    }
    
    private func passwordAreNotTheSameAlert(){
        
        let alert = UIAlertController(title: "Error!",
                                      message: "Passwords must be equals.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: { action in
                                        self.vwUnderlinePasswordOne?.backgroundColor = UIColor.red
                                        self.vwUnderlinePasswordTwo?.backgroundColor = UIColor.red
                                        self.txtPasswordOne?.text = nil
                                        self.txtPasswordTwo?.text = nil
                                        self.txtPasswordOne?.becomeFirstResponder()
        }))
        
        self.present(alert, animated: true)
    }
    
    private func emailFieldIncorrectlyFilled(){
        
        let alert = UIAlertController(title: "Error!",
                                      message: "Fill the text field with a valid email.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: { action in
                                        self.txtEmail?.text = nil
        }))
        
        self.present(alert, animated: true)
    }
    
    private func emailFieldIsEmpty() {
        
        let alert = UIAlertController(title: "Error!",
                                      message: "Fill the text field with an email.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: { action in
                                        self.txtEmail?.text = nil
        }))
        
        self.present(alert, animated: true)
        
    }
    
}



