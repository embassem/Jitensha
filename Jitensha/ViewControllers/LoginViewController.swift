//
//  LoginViewController.swift
//  GooTaxi
//
//  Created by Bassem Abbas on 7/30/16.
//  Copyright © 2017 ADLANC.COM. All rights reserved.
//

import UIKit
import TextFieldEffects
import Validator
import PopupDialog


class LoginViewController: UIViewController {
    
 
    @IBOutlet weak var emailTextField: HoshiTextField!
    
    @IBOutlet weak var passwordTextField: HoshiTextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    var viewModel:AuthViewModel!

    override func viewDidLoad() {
        super.viewDidLoad();
        
        emailTextField.delegate = self;
        passwordTextField.delegate = self;

        self.view.layoutIfNeeded()
    }
    
    
    @IBAction func serverLoginButtonClicked() {

        self.validate();
    }
    

    
    @IBAction func presnetRegisterViewController(){
        
        let registerVC = ViewControllers.registerViewController(authViewModel: self.viewModel);
        self.navigationController?.pushViewController(registerVC, animated: true);
        
    }

    
    @IBAction func  forgetPassword(sender:UIButton){

    }

    
       

    func validate(){
        var valid:Bool = true;
        
        var emailRules = ValidationRuleSet<String>()

        let emailRequiredRule =  ValidationRuleLength(min: 1, error: ValidationError(message: "Required Email"))
        emailRules.add(rule: emailRequiredRule)
        
        let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError(message: "Email Not Valid"));
        emailRules.add(rule: emailRule)
        
        let emailResult = emailTextField.validate(rules: emailRules);
        switch emailResult {
        case .valid:
            emailTextField.borderActiveColor = UIColor.white;
            emailTextField.borderInactiveColor = UIColor.white;
        case .invalid(let errors):
            valid = false;
            emailTextField.borderActiveColor = UIColor.red;
            emailTextField.borderInactiveColor = UIColor.red;
        }
        
        
        var passwordRules = ValidationRuleSet<String>()
        
        let passwordRequiredRule =  ValidationRuleLength(min: 3, error: ValidationError(message: "Required Password"))
        passwordRules.add(rule: passwordRequiredRule)
        
      
        
        let passwordResult = passwordTextField.validate(rules: passwordRules);
        switch passwordResult {
        case .valid:
            passwordTextField.borderActiveColor = UIColor.white;
            passwordTextField.borderInactiveColor = UIColor.white;
          case .invalid(let errors):
            passwordTextField.borderActiveColor = UIColor.red;
            passwordTextField.borderInactiveColor = UIColor.red;
        }
        
        
        
        if valid {
            let loginModel = AuthModel(email: self.emailTextField.text!, password: self.passwordTextField.text!);
           viewModel.procideLoginProcess(loginModel: loginModel);

        }else {
            
            Shared.HUD.ErrorHUD("Error".localized(), message: "Please Check all Filed".localized(), hideafter: 2);
            
        }
        
        
        
    }
    
   
    
 
}

extension LoginViewController:UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField) {
        //var valid:Bool = true;
        
        switch  textField.tag {
        case 60:
            var emailRules = ValidationRuleSet<String>()
            let emailRequiredRule =  ValidationRuleLength(min: 1,error: ValidationError(message: "Error Validation"))
            emailRules.add(rule: emailRequiredRule)
            
            let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError(message: "Error Validation"));
            emailRules.add(rule: emailRule)
            
            let emailResult = emailTextField.validate(rules: emailRules);
            switch emailResult {
            case .valid:
                emailTextField.borderActiveColor = UIColor.white;
                emailTextField.borderInactiveColor = UIColor.white;
            case .invalid(let errors):
                emailTextField.borderActiveColor = UIColor.red;
                emailTextField.borderInactiveColor = UIColor.red;
            }
        case 61:
            
            var passwordRules = ValidationRuleSet<String>()
            
            let passwordRequiredRule =  ValidationRuleLength(min: 1, error: ValidationError(message: "Error Validation"))
            passwordRules.add(rule: passwordRequiredRule)
            let passwordResult = passwordTextField.validate(rules: passwordRules);
            switch passwordResult {
            case .valid:
                passwordTextField.borderActiveColor = UIColor.white;
                passwordTextField.borderInactiveColor = UIColor.white;
             case .invalid(let errors):
                passwordTextField.borderActiveColor = UIColor.red;
                passwordTextField.borderInactiveColor = UIColor.red;
            }
        default: break
            
        }
    }
    
}



