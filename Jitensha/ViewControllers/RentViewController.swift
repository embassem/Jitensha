//
//  RentViewController.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/10/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import UIKit
import Caishen


class RentViewController: UIViewController {

    
    var viewModel:MapViewModel!
    
    @IBOutlet weak var buyButton: UIButton?
    @IBOutlet weak var cardNumberTextField: CardTextField!
    
    @IBOutlet weak var cardHolderNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers();
        cardNumberTextField.cardTextFieldDelegate = self
    }
    
    deinit {
        self.RemoveObservers()
    }
    
    @IBAction func buy(_ sender: AnyObject) {
        
        if(cardHolderNameTextField.text != nil && (cardHolderNameTextField.text?.isNotEmpty)! )
        {
        
        
          
            viewModel.rentCurrentPlace(cardHolder: cardHolderNameTextField.text!, cardNumber: cardNumberTextField.card.bankCardNumber.rawValue, cardExpiry: cardNumberTextField.card.expiryDate.description, cardCode: cardNumberTextField.card.cardVerificationCode.rawValue)
        }else {
            
            Shared.AlertDialog.alertWithDismiss("Error", message: "Error Card data not Valid", image: nil, cancelTitleKey: "OK");
            
        }
    }
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @objc private func didRentPlace(notification : NSNotification){
        
        
        dismiss(animated: true) { 
            
            // will display service response Message  in an Alert.
            Shared.AlertDialog.alertWithDismiss("Alert", message: notification.object as! String, image: nil, cancelTitleKey: "Ok");
        }
        
    }
    
    private func setupObservers(){
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(RentViewController.didRentPlace(notification:)), name: NSNotification.Name(rawValue: "didRentPlace"), object: nil)
        
        
    }
    
    
    private func RemoveObservers(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "didRentPlace"), object: nil);
        
    }
    
    
    
    
}
    // MARK: - CardNumberTextField delegate methods
    extension RentViewController:CardTextFieldDelegate{
    // This method of `CardNumberTextFieldDelegate` will set the saveButton enabled or disabled, based on whether valid card information has been entered.
    func cardTextField(_ cardTextField: CardTextField, didEnterCardInformation information: Card, withValidationResult validationResult: CardValidationResult) {
        buyButton?.isEnabled = validationResult == .Valid && (cardHolderNameTextField.text?.isNotEmpty)!
    }
    
    func cardTextFieldShouldShowAccessoryImage(_ cardTextField: CardTextField) -> UIImage? {
        return UIImage(named: "camera")
    }
    
    func cardTextFieldShouldProvideAccessoryAction(_ cardTextField: CardTextField) -> (() -> ())? {
        return { [weak self] _ in
            guard let cardIOViewController = CardIOPaymentViewController(paymentDelegate: self) else {
                return
            }
            self?.present(cardIOViewController, animated: true, completion: nil)
        }
    }
}
    // MARK: - Card.io delegate methods
        extension RentViewController:CardIOPaymentViewControllerDelegate{

    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        cardNumberTextField.prefill(cardInfo.cardNumber, month: Int(cardInfo.expiryMonth), year: Int(cardInfo.expiryYear), cvc: cardInfo.cvv)
        self.cardHolderNameTextField.text = cardInfo.cardholderName;
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
}

