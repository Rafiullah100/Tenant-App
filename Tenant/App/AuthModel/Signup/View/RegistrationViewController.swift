//
//  RegistrationViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit
import SpinKit
class RegistrationViewController: BaseViewController {

   
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var userTypeTextField: UITextField!
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
    @IBOutlet weak var languageLabel: UILabel!

    var userType: UserType?
   var pickerView = UIPickerView()
   let userArray = [LocalizationKeys.owner.rawValue.localizeString(), LocalizationKeys.tenantWithoutColon.rawValue.localizeString(), LocalizationKeys.company.rawValue.localizeString(),
                   LocalizationKeys.workers.rawValue.localizeString()]
    
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
        userTypeTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        userTypeTextField.placeholder = LocalizationKeys.selectUserType.rawValue.localizeString()
        userTypeLabel.text = LocalizationKeys.selectUserType.rawValue.localizeString()
        languageLabel.text = Helper.shared.isRTL() ? LocalizationKeys.arabic.rawValue.localizeString() : LocalizationKeys.english.rawValue.localizeString()

        userTypeTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        contactTextField.delegate = self
        
        viewModel.signup.bind { [unowned self] signup in
            guard let signup = signup else{return}
            self.stopAnimation()
            if signup.success == true{
                Switcher.gotoOtpScreen(delegate: self, userType: userType ?? .tenant, contact: contactTextField.text ?? "", otpType: .signup, otp: signup.user?.otp ?? "")
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
    
    @IBAction func changeLanguage(_ sender: Any) {
        Switcher.gotoMenu(delegate: self, menuType: .language)
    }
    
    @IBAction func gotoSignBtnAction(_ sender: Any) {
        Switcher.gotoSigninScreen(delegate: self)
    }
    
    @IBAction func registerBtnAction(_ sender: Any) {
        let signup = SignupInputModel(userType: userType?.rawValue ?? "", email: emailTextField.text ?? "", mobile: contactTextField.text ?? "", name: nameTextField.text ?? "")
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

extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTypeTextField.text = userArray[row]
        if row == 0 {
            userType = .owner
        }
        else if row == 1 {
            userType = .tenant
        }
        else if row == 2 {
            userType = .company
        }
        else if row == 3 {
            userType = .worker
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var currentText = textField.text ?? ""
        if let stringRange = Range(range, in: currentText) {
            currentText = currentText.replacingCharacters(in: stringRange, with: string)
        }
        let numbersOnly = currentText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        textField.text = Helper.shared.formatPhoneNumber(numbersOnly)
        return false
    }
}
