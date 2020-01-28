//
//  RegisterViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 11/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import RKDropdownAlert

class RegisterViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!

    var imagePicker: ImagePicker!
    
    @IBOutlet var txtName: UITextField?
    @IBOutlet var txtEmail: UITextField?
    @IBOutlet var txtPasswordOne: UITextField?
    @IBOutlet var txtPasswordTwo: UITextField?
    @IBOutlet var txtTwitter: UITextField?
    
    @IBOutlet var btnAvatar: UIButton?
    
    @IBOutlet var svScrollView: UIScrollView?
    
    @IBOutlet var btnRegister: UIButton?
    
    @IBOutlet var vwUnderlineName: UIView?
    @IBOutlet var vwUnderlineEmailRegister: UIView?
    @IBOutlet var vwUnderlinePasswordOne: UIView?
    @IBOutlet var vwUnderlinePasswordTwo: UIView?
    @IBOutlet var vwUnderlineTwitter: UIView?
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
    @IBOutlet var constraintAlignCenterTwitter: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlineTwitter: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterAvatar: NSLayoutConstraint?
    
    let defaults = UserDefaults.standard
    
    //---------------------------------------------------------------------------------------------
    //  MARK: - UIViewController
    //---------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideForms()
        
        self.centerConstraints()
        
        self.animateCloud()
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.svScrollView?.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: 1200)
        
        self.animateForms()

        self.showForms()
        
    }
    
    //---------------------------------------------------------------------------------------------
    //  MARK: - Private Functions
    //---------------------------------------------------------------------------------------------
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction private func backToLogin() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func registerButton() {
        
        if let text = self.txtEmail?.text, text.isEmpty != true {
        
                if Util.validate(email: text) { //Email validated
                    
                    if self.checkPasswordField() {
                    
                        if self.validatePassword() { //Password validated
                            
                            if self.checkIfEmailAlreadyExists() {
                                
                                let alert = UIAlertController(title: "Error!",
                                                          message: "The email already exists",
                                                          preferredStyle: .alert)

                                alert.addAction(UIAlertAction(title: "Confirm",
                                                          style: .default,
                                                          handler: { action in
                                                            self.txtEmail?.text = nil
                                                            self.vwUnderlineEmailRegister?.backgroundColor = UIColor.red

                                }))

                                self.present(alert, animated: true)

                                if let fieldEmail = txtEmail {
                                    Util.tintPlaceholder(field: fieldEmail, color: .red)
                                }
                            }else{
                            
                            // register user
                            
                            let user: Dictionary<String, String> = [Constants.Key.userName : (self.txtName?.text)!,
                                                                    Constants.Key.userEmail : (self.txtEmail?.text)!,
                                                                    Constants.Key.userPassword : (self.txtPasswordOne?.text)!]
                            
                            PersistManager.set(data: user)
                            
                            Util.showMessage(text: "Succefully registrated!", type: .success)
                            
                            self.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                    }
                }else{  //Email invalid
                    
                    Util.showMessage(text: "Fill the text field with a valid email.", type: .warning)
                    
                    self.txtEmail?.text = nil
                }
                
            }else{ //Field is Empty
                
                Util.showMessage(text: "Fill the text field with an email.", type: .warning)
                
                self.txtEmail?.text = nil
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
        
        Util.showMessage(text: "Password must be equals!", type: .warning)
        
        self.vwUnderlinePasswordOne?.backgroundColor = UIColor.red
        self.vwUnderlinePasswordTwo?.backgroundColor = UIColor.red
        self.txtPasswordOne?.text = nil
        self.txtPasswordTwo?.text = nil
        self.txtPasswordOne?.becomeFirstResponder()
    }
    
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
    
    private func hideForms(){
        
        self.btnAvatar?.alpha = 0
        self.txtName?.alpha = 0
        self.vwUnderlineName?.alpha = 0
        self.txtEmail?.alpha = 0
        self.vwUnderlineEmailRegister?.alpha = 0
        self.txtPasswordOne?.alpha = 0
        self.vwUnderlinePasswordOne?.alpha = 0
        self.txtPasswordTwo?.alpha = 0
        self.btnRegister?.alpha = 0
        self.btnRegister?.alpha = 0
        self.txtTwitter?.alpha = 0
        self.vwUnderlineTwitter?.alpha = 0
    }
    
    private func showForms(){
        
        UIView.animate(withDuration: 1.5, animations: {self.btnAvatar?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtName?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlineName?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtEmail?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlineEmailRegister?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtPasswordOne?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlinePasswordOne?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtPasswordTwo?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlinePasswordTwo?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.btnRegister?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtTwitter?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlineTwitter?.alpha = 1})
    }
    
    private func animateForms(){
        
        constraintAlignCenterAvatar?.constant = 0
        
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.view.layoutIfNeeded()
        }
        
        constraintAlignCenterName?.constant = 0
        constraintAlignCenterUnderlineName?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.2,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterEmail?.constant = 0
        constraintAlignCenterUnderlineEmail?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.3,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterTwitter?.constant = 0
        constraintAlignCenterUnderlineTwitter?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.4,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)

        constraintAlignCenterPasswordOne?.constant = 0
        constraintAlignCenterUnderlinePasswordOne?.constant = 0

        UIView.animate(withDuration: 0.5,
                     delay: 0.5,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterPasswordTwo?.constant = 0
        constraintAlignCenterUnderlinePasswordTwo?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.6,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
                
        constraintAlignCenterRegisterButton?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.7,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func centerConstraints(){
       
        constraintAlignCenterAvatar?.constant -= view.bounds.width
        constraintAlignCenterName?.constant -= view.bounds.width
        constraintAlignCenterUnderlineName?.constant -= view.bounds.width
        constraintAlignCenterEmail?.constant -= view.bounds.width
        constraintAlignCenterUnderlineEmail?.constant -= view.bounds.width
        constraintAlignCenterPasswordOne?.constant -= view.bounds.width
        constraintAlignCenterUnderlinePasswordOne?.constant -= view.bounds.width
        constraintAlignCenterPasswordTwo?.constant -= view.bounds.width
        constraintAlignCenterUnderlinePasswordTwo?.constant -= view.bounds.width
        constraintAlignCenterRegisterButton?.constant -= view.bounds.width
        constraintAlignCenterTwitter?.constant -= view.bounds.width
        constraintAlignCenterUnderlineTwitter?.constant -= view.bounds.width
    }
    
    private func validatePassword() -> Bool {
        
        if self.txtPasswordOne?.text == self.txtPasswordTwo?.text {
            
            return true
        }else {
              
            self.passwordAreNotTheSame()
            self.passwordAreNotTheSameAlert()
            
            return false
        }
    }
    
    private func checkPasswordField() -> Bool {
        
        if self.txtPasswordOne?.text == "" {
            
            RKDropdownAlert.title(nil, message: "You need to fill the password field!", backgroundColor: UIColor.red, textColor: UIColor.white, time: 3)
            
            return false
        }else{
            return true
        }
    }
    
    private func checkIfEmailAlreadyExists() -> Bool {

        let array = PersistManager.get()

        for item in array {

            if item[Constants.Key.userEmail] == txtEmail?.text {

                return true
            }
        }
        return false
    }
    
    private func checkNameField() -> Bool {
        
        if txtName == nil {
            
            return true
        }
        return false
    }
    
    private func configUI() {
        
        if let fieldName = txtName {
            Util.tintPlaceholder(field: fieldName, color: .white)
        }
        
        if let fieldEmail = txtEmail {
            Util.tintPlaceholder(field: fieldEmail, color: .white)
        }
        
        if let fieldTwitter = txtTwitter {
            Util.tintPlaceholder(field: fieldTwitter, color: .white)
        }
        
        if let fieldPasswordOne = txtPasswordOne {
            Util.tintPlaceholder(field: fieldPasswordOne, color: .white)
        }
        if let fieldPasswordTwo = txtPasswordTwo {
            Util.tintPlaceholder(field: fieldPasswordTwo, color: .white)
        }
    }
}

extension RegisterViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}




