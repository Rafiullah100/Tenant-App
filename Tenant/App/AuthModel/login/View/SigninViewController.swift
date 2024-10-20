//
//  SigninViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit
import SpinKit
class SigninViewController: BaseViewController {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var userTypeTextField: UITextField!
    @IBOutlet weak var curveImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var noAccountLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signinLabel: UILabel!
   
    var userType: UserType?
    var pickerView = UIPickerView()
    let userArray = [LocalizationKeys.owner.rawValue.localizeString(), LocalizationKeys.tenantWithoutColon.rawValue.localizeString(), LocalizationKeys.company.rawValue.localizeString(),
                    LocalizationKeys.workers.rawValue.localizeString()]

    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /////03046929792
//        emailTextField.text = "87654321"

        nameTextField.text = "Rafiullah"
        emailTextField.delegate = self
        userTypeTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        
        curveImageView.image = UIImage(named: Helper.shared.isRTL() ? "bg-ar" : "bg")
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        emailTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        userTypeTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        userTypeTextField.placeholder = LocalizationKeys.selectUserType.rawValue.localizeString()

        signinLabel.text = LocalizationKeys.signin.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.name.rawValue.localizeString()
        userTypeLabel.text = LocalizationKeys.selectUserType.rawValue.localizeString()
        userNameLabel.text = LocalizationKeys.numberOrEmail.rawValue.localizeString()
        noAccountLabel.text = LocalizationKeys.noAccount.rawValue.localizeString()
        submitButton.setTitle(LocalizationKeys.submit.rawValue.localizeString(), for: .normal)
        signupButton.setTitle(LocalizationKeys.signup.rawValue.localizeString(), for: .normal)
        languageLabel.text = Helper.shared.isRTL() ? LocalizationKeys.arabic.rawValue.localizeString() : LocalizationKeys.english.rawValue.localizeString()
        
        viewModel.login.bind { [unowned self] login in
            guard let login = login else {return}
            self.stopAnimation()
            if login.success == true{
                Switcher.gotoOtpScreen(delegate: self, userType: userType ?? .tenant, contact: emailTextField.text ?? "", otpType: .signin, otp: viewModel.login.value?.otp ?? "")
            }
            else{
                showAlert(message: login.message ?? "")
            }
        }
    }
    @IBAction func changeLanguage(_ sender: Any) {
        Switcher.gotoMenu(delegate: self, menuType: .language)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func noAccountBtnAction(_ sender: Any) {
        Switcher.gotoRegisterScreen(delegate: self)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        let login = LoginInputModel(userType: userType?.rawValue ?? "", number: emailTextField.text ?? "", name: nameTextField.text ?? "")
        print(login)
        let validationResponse = viewModel.isFormValid(user: login)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.loginUser()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
}

extension SigninViewController: UIPickerViewDelegate, UIPickerViewDataSource{
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

extension SigninViewController: UITextFieldDelegate{
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

