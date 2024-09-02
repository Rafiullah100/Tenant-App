//
//  RegistrationViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit
import SpinKit
class RegistrationViewController: BaseViewController {

   
    @IBOutlet weak var curveImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var signinLabel: UIButton!
    @IBOutlet weak var alreadyRegisteredLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var optionalLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    private var viewModel = SignupViewModel()
    var userType: UserType = .tenant
    override func viewDidLoad() {
        super.viewDidLoad()
        curveImageView.image = UIImage(named: Helper.shared.isRTL() ? "bg-ar" : "bg")
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        contactTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        emailTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        registrationLabel.text = LocalizationKeys.registration.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.name.rawValue.localizeString()
        numberLabel.text = LocalizationKeys.contactNumber.rawValue.localizeString()
        emailLabel.text = LocalizationKeys.email.rawValue.localizeString()
        optionalLabel.text = "(\(LocalizationKeys.optional.rawValue.localizeString()))"
        alreadyRegisteredLabel.text = LocalizationKeys.alreadyRegistered.rawValue.localizeString()
        signinLabel.setTitle(LocalizationKeys.signin.rawValue.localizeString(), for: .normal)
        submitButton.setTitle(LocalizationKeys.submit.rawValue.localizeString(), for: .normal)
        
        viewModel.signup.bind { [unowned self] signup in
            guard let signup = signup else{return}
            self.stopAnimation()
            if signup.success == true{
                Switcher.gotoOtpScreen(delegate: self, userType: userType, contact: contactTextField.text ?? "", otpType: .signup)
            }
            else{
                showAlert(message: signup.message ?? "")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func registerBtnAction(_ sender: Any) {
        let signup = SignupInputModel(userType: userType.rawValue, email: emailTextField.text ?? "", mobile: contactTextField.text ?? "", name: nameTextField.text ?? "")
        let validationResponse = viewModel.isFormValid(user: signup)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.signupUser()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
}


