//
//  OTPViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit

class OTPViewController: BaseViewController {

    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var receiveLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    var userType: UserType = .tenant
    private var viewModel = OtpViewModel()

    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textField1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .otpBack
        topLabel.text = LocalizationKeys.verifyNumber.rawValue.localizeString()
        messageLabel.text = LocalizationKeys.optMessage.rawValue.localizeString()
        receiveLabel.text = LocalizationKeys.didnotReceiveCode.rawValue.localizeString()
        resendButton.setTitle(LocalizationKeys.resend.rawValue.localizeString(), for: .normal)
        verifyButton.setTitle(LocalizationKeys.verify.rawValue.localizeString(), for: .normal)
        
        textField1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textfield2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
   
        viewModel.otp.bind { [unowned self] otp in
            guard let otp = otp else{return}
            self.stopAnimation()
            if otp.success == true{
                switch Helper.shared.userType() {
                case .owner:
                    Switcher.gotoOwnerHome(delegate: self)
                case .tenant:
                    Switcher.gotoTenantScreen(delegate: self)
                case .company:
                    Switcher.gotoCompanyScreen(delegate: self)
                case .worker:
                    Switcher.gotoWorkerScreen(delegate: self)
                }
            }
            else{
                showAlert(message: otp.message ?? "")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text
        
        if text?.count == 1 {
            switch textField {
            case textField1:
                textfield2.becomeFirstResponder()
            case textfield2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            case textField4:
                textField4.resignFirstResponder()
            default:
                break
            }
        } else if text?.count == 0 {
            switch textField {
            case textField4:
                textField3.becomeFirstResponder()
            case textField3:
                textfield2.becomeFirstResponder()
            case textfield2:
                textField1.becomeFirstResponder()
            default:
                break
            }
        }
    }
    func getOTP() -> String {
        let otp1 = (textField1.text ?? "") + (textfield2.text ?? "")
        let otp2 = (textField3.text ?? "") + (textField4.text ?? "")
        return otp1 + otp2
    }

    @IBAction func verifyBtnAction(_ sender: Any) {
        let otp = getOTP()
        if otp.count < 4{
            showAlert(message: "Please fill all field and try again!")
        }
        else{
            viewModel.verifyUSer(otp: otp, type: userType.rawValue)
        }
    } 
}

