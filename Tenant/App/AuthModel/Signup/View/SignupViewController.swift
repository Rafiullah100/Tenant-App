//
//  SignupViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var curveImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var signupLabel: UILabel!

    
    @IBOutlet weak var textField: UITextField!
     var userType: UserType?
    var pickerView = UIPickerView()
    let userArray = [LocalizationKeys.owner.rawValue.localizeString(), LocalizationKeys.tenantWithoutColon.rawValue.localizeString(), LocalizationKeys.company.rawValue.localizeString(),
                    LocalizationKeys.workers.rawValue.localizeString()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curveImageView.image = UIImage(named: Helper.shared.isRTL() ? "bg-ar" : "bg")
        signupLabel.text = LocalizationKeys.signup.rawValue.localizeString()
        chooseLabel.text = LocalizationKeys.chooseOne.rawValue.localizeString()
        continueButton.setTitle(LocalizationKeys.continuee.rawValue.localizeString(), for: .normal)
        textField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        guard let userType = userType else {
            print("select user first")
            return
        }
        Switcher.gotoSigninScreen(delegate: self, userType: userType)
    }
}

extension SignupViewController: UIPickerViewDelegate, UIPickerViewDataSource{
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
        textField.text = userArray[row]
        if row == 0 {
            userType = .owner
        }
        else if row == 1 {
            userType = .tenant
        }
        else if row == 3 {
            userType = .company
        }
        else if row == 4 {
            userType = .worker
        }

    }
}
