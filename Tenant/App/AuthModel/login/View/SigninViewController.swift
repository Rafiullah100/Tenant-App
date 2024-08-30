//
//  SigninViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit
import SpinKit
class SigninViewController: BaseViewController {

    @IBOutlet weak var curveImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var noAccountLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signinLabel: UILabel!
    var userType: UserType = .tenant

    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /////03046929792
        //tenant
        emailTextField.text = "123456789"
        
        //company
//        emailTextField.text = "3244-3256346"
//                emailTextField.text = "123456789"
        
        //owner
        emailTextField.text = "03009911223"
//        emailTextField.text = "03046929792"
        //worker
//        emailTextField.text = "123456789"
        
        nameTextField.text = "Rafiullah"
        
        curveImageView.image = UIImage(named: Helper.shared.isRTL() ? "bg-ar" : "bg")
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        emailTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        signinLabel.text = LocalizationKeys.signin.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.name.rawValue.localizeString()
        userNameLabel.text = LocalizationKeys.numberOrEmail.rawValue.localizeString()
        noAccountLabel.text = LocalizationKeys.noAccount.rawValue.localizeString()
        submitButton.setTitle(LocalizationKeys.submit.rawValue.localizeString(), for: .normal)
        signupButton.setTitle(LocalizationKeys.signup.rawValue.localizeString(), for: .normal)
        
        viewModel.login.bind { [unowned self] login in
            guard let login = login else {return}
            self.stopAnimation()
            if login.success == true{
                Switcher.gotoOtpScreen(delegate: self, userType: userType, contact: emailTextField.text ?? "")
            }
            else{
                showAlert(message: login.message ?? "")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func noAccountBtnAction(_ sender: Any) {
        Switcher.gotoRegisterScreen(delegate: self, userType: userType)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        let login = LoginInputModel(userType: userType.rawValue, number: emailTextField.text ?? "", name: nameTextField.text ?? "")
        let validationResponse = viewModel.isFormValid(user: login)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.loginUser()
        }
        else{
            showAlert(message: validationResponse.message)
        }
        
//        switch userType {
//        case .owner:
//            Switcher.gotoOwnerHome(delegate: self)
//        case .tenant:
//            Switcher.gotoTenantScreen(delegate: self)
//        case .company:
//            Switcher.gotoCompanyScreen(delegate: self)
//        case .worker:
//            Switcher.gotoWorkerScreen(delegate: self)
//        }
    }
}
