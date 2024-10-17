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
    var otp: String?
    var userType: UserType = .tenant
    private var viewModel = OtpViewModel()
    var contact: String?
    
    var otpType: OtpType?
    
    
    @IBOutlet var otpViews: [UIView]!
    
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textField1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .otpBack
        otpViews.forEach { view in
            view.semanticContentAttribute = .forceLeftToRight
        }
        otpView.semanticContentAttribute = .forceLeftToRight
        topLabel.text = LocalizationKeys.verifyNumber.rawValue.localizeString()
        messageLabel.text = "\(LocalizationKeys.otpMessage1.rawValue.localizeString()) ******\(contact?.suffix(4) ?? ""). \(LocalizationKeys.otpMessage2.rawValue.localizeString())"
        receiveLabel.text = LocalizationKeys.didnotReceiveCode.rawValue.localizeString()
        resendButton.setTitle(LocalizationKeys.resend.rawValue.localizeString(), for: .normal)
        verifyButton.setTitle(LocalizationKeys.verify.rawValue.localizeString(), for: .normal)
        
        textField1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textfield2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        let array = Array(otp ?? "")
//        textField1.text = "\(array[0])"
//        textfield2.text = "\(array[1])"
//        textField3.text = "\(array[2])"
//        textField4.text = "\(array[3])"

        textField1.becomeFirstResponder()
        
        if otpType == .signin{
            viewModel.loginOtp.bind { [unowned self] otp in
                guard let otp = otp else{return}
                self.stopAnimation()
                if otp.success == true{
                   gotoHome()
                }
                else{
                    showAlert(message: otp.message ?? "")
                }
            }
        }
        else{
            viewModel.otp.bind { [unowned self] otp in
                guard let otp = otp else{return}
                self.stopAnimation()
                if otp.success == true{
                   gotoHome()
                }
                else{
                    showAlert(message: otp.message ?? "")
                }
            }
        }
        
        viewModel.resendOtp.bind { [unowned self] resendOtp in
            guard let resendOtp = resendOtp else{return}
            self.stopAnimation()
            showAlert(message: resendOtp.message ?? "")
        }
    }
    
    private func gotoHome(){
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func resendBtnAction(_ sender: Any) {
        self.animateSpinner()
        viewModel.resendOtp(type: userType.rawValue, contact: contact ?? "")
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
            showAlert(message: LocalizationKeys.pleaseFillAll.rawValue.localizeString())
        }
        else{
            self.animateSpinner()
            if otpType == .signin{
                viewModel.loginUSer(otp: otp, type: userType.rawValue, contact: contact ?? "")
            }
            else{
                viewModel.verifyUSer(otp: otp, type: userType.rawValue, contact: contact ?? "")
            }
        }
    } 
}


extension String {
    subscript(_ index: Int) -> Character? {
        guard index >= 0, index < self.count else {
            return nil
        }

        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
