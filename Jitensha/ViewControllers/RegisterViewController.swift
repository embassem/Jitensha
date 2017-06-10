//
//  LoginViewController.swift
//  GooTaxi
//
//  Created by Bassem Abbas on 7/30/16.
//  Copyright © 2017 ADLANC.COM. All rights reserved.
//
import UIKit
import TextFieldEffects
import Localize_Swift
import PopupDialog
import Validator

class RegisterViewController: UIViewController {





//MARK:- IBOutlet
    @IBOutlet weak var registerBtn: UIButton!

    @IBOutlet weak var emailTextField: HoshiTextField!

    @IBOutlet weak var passwordTextField: HoshiTextField!


//MARK:- Variables
    var viewModel: AuthViewModel!

    
    
    //MARK:- View Life cycle
    override func viewDidLoad() {


        super.viewDidLoad();
        emailTextField.delegate = self;
        passwordTextField.delegate = self;


    }


//MARK:- BAction

    @IBAction func serverRegisterButtonClicked() {

        self.validate();

    }






    @IBAction func backToLoginRegister(_ sender: UIButton) {
        debugPrint("backToLoginFromRegister")
        self.navigationController?.popViewController(animated: true);

    }


//MARK:- private  func
    
 fileprivate  func alertFailedRegisteration() {

        // Prepare the popup assets
        let title = "Registeration".localized()
        let message = "Registeration Failed".localized()
        let image = UIImage(named: "pexels-photo-103290")

        // Create the dialog
        let popup = PopupDialog(title: title, message: message);
        popup.transitionStyle = .fadeIn



        let cancel = CancelButton(title: "Close".localized()) {


        }



        popup.addButtons([cancel])
        // Present dialog
        self.present(popup, animated: true, completion: nil)



    }


  fileprivate  func validate() {
        var valid: Bool = true;



        var emailRules = ValidationRuleSet<String>()

        let emailRequiredRule = ValidationRuleLength(min: 1, error: ValidationError(message: "helllo"))
        emailRules.add(rule: emailRequiredRule)

        let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError(message: "helllo"));
        emailRules.add(rule: emailRule)

        let emailResult = emailTextField.validate(rules: emailRules);
        switch emailResult {
        case .valid:
            emailTextField.borderActiveColor = UIColor.white;
            emailTextField.borderInactiveColor = UIColor.white;
        case .invalid(let errors): valid = false;
            emailTextField.borderActiveColor = UIColor.red;
            emailTextField.borderInactiveColor = UIColor.red;
        }




        var passwordRules = ValidationRuleSet<String>()

        let passwordRequiredRule = ValidationRuleLength(min: 3, error: ValidationError(message: "helllo"))
        passwordRules.add(rule: passwordRequiredRule)

        let passwordRule = ValidationRuleLength(min: 3, error: ValidationError(message: "helllo"))
        passwordRules.add(rule: passwordRule)

        let passwordResult = passwordTextField.validate(rules: passwordRules);
        switch passwordResult {
        case .valid:
            passwordTextField.borderActiveColor = UIColor.white;
            passwordTextField.borderInactiveColor = UIColor.white;
        case .invalid(let errors):

            valid = false;
            passwordTextField.borderActiveColor = UIColor.red;
            passwordTextField.borderInactiveColor = UIColor.red;

        }





        if valid {

            let registerModel = AuthModel(email: self.emailTextField.text!, password: self.passwordTextField.text!);

            viewModel.registerUser(registerModel: registerModel);

        } else {

            Shared.HUD.ErrorHUD("Error".localized(), message: "Please Check from all Filed".localized(), hideafter: 2);



        }



    }

}


//MARK:- UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField) {
        //var valid:Bool = true;

        switch textField.tag {

        case 51:
            var emailRules = ValidationRuleSet<String>()

            let emailRequiredRule = ValidationRuleLength(min: 1, error: ValidationError(message: "helllo"))
            emailRules.add(rule: emailRequiredRule)

            let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError(message: "helllo"));
            emailRules.add(rule: emailRule)

            let emailResult = emailTextField.validate(rules: emailRules);
            switch emailResult {
            case .valid:
                emailTextField.borderActiveColor = UIColor.white;
                emailTextField.borderInactiveColor = UIColor.white;
            case .invalid(let errors):
                // valid = false;
                emailTextField.borderActiveColor = UIColor.red;
                emailTextField.borderInactiveColor = UIColor.red;
            }

        case 53:
            var passwordRules = ValidationRuleSet<String>()

            let passwordRequiredRule = ValidationRuleLength(min: 1, error: ValidationError(message: "Password Required"))
            passwordRules.add(rule: passwordRequiredRule)

            let passwordRule = ValidationRuleLength(min: 3, error: ValidationError(message: "Password too short"))
            passwordRules.add(rule: passwordRule)

            let passwordResult = passwordTextField.validate(rules: passwordRules);
            switch passwordResult {
            case .valid:
                passwordTextField.borderActiveColor = UIColor.white;
                passwordTextField.borderInactiveColor = UIColor.white;
            case .invalid(let errors):
                //valid = false;
                passwordTextField.borderActiveColor = UIColor.red;
                passwordTextField.borderInactiveColor = UIColor.red;
            }


        default: break

        }



    }

}

