//
//  RegistrationViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit

class RegistrationViewController: UIViewController {

   
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
    }
}
