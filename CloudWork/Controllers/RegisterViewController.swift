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
    @IBOutlet var vwCloud: UIView?
    
    @IBOutlet var constraintAlignCenterInfo: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterName: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlineName: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterEmail: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlineEmail: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterPasswordOne: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlinePasswordOne: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterPasswordTwo: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlinePasswordTwo: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterRegisterButton: NSLayoutConstraint?
    
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
        
        constraintAlignCenterInfo?.constant -= view.bounds.width
        constraintAlignCenterName?.constant -= view.bounds.width
        constraintAlignCenterUnderlineName?.constant -= view.bounds.width
        constraintAlignCenterEmail?.constant -= view.bounds.width
        constraintAlignCenterUnderlineEmail?.constant -= view.bounds.width
        constraintAlignCenterPasswordOne?.constant -= view.bounds.width
        constraintAlignCenterUnderlinePasswordOne?.constant -= view.bounds.width
        constraintAlignCenterPasswordTwo?.constant -= view.bounds.width
        constraintAlignCenterUnderlinePasswordTwo?.constant -= view.bounds.width
        constraintAlignCenterRegisterButton?.constant -= view.bounds.width
        
        self.animateCloud()
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        constraintAlignCenterInfo?.constant = 0
        
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.view.layoutIfNeeded()
        }
        
        constraintAlignCenterName?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.2,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        constraintAlignCenterUnderlineName?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.2,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterEmail?.constant = 0
        UIView.animate(withDuration: 0.5,
                     delay: 0.3,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterUnderlineEmail?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.3,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterPasswordOne?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.4,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterUnderlinePasswordOne?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.4,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterPasswordTwo?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.5,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterUnderlinePasswordTwo?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.5,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterRegisterButton?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.6,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
     
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
                       
                   }else{
                       //Email invalid
                       self.emailFieldIncorrectlyFilled()
                   }
               }else{
                   //Field is Empty
                   self.emailFieldIsEmpty()
               }
        
        if self.txtPasswordOne?.text == self.txtPasswordTwo?.text {
            
            let alert = UIAlertController(title: "Registered successfully!",
                                          message: "Confirm your email to validate the account.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Confirm",
                                          style: .default,
                                          handler: {actio in self.backToLogin()}))
            
            self.present(alert,
                         animated: true)
        }else {
              
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
    
    // MARK: - Animate
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
}



