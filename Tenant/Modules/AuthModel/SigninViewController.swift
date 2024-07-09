//
//  SigninViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var curveImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var noAccountLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signinLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        curveImageView.image = UIImage(named: Helper.shared.isRTL() ? "bg-ar" : "bg")
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        emailTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        signinLabel.text = LocalizationKeys.signin.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.name.rawValue.localizeString()
        userNameLabel.text = LocalizationKeys.numberOrEmail.rawValue.localizeString()
        noAccountLabel.text = LocalizationKeys.noAccount.rawValue.localizeString()
        submitButton.setTitle(LocalizationKeys.submit.rawValue.localizeString(), for: .normal)
        signupButton.setTitle(LocalizationKeys.signup.rawValue.localizeString(), for: .normal)
    }
}
