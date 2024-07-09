//
//  OTPViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var receiveLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = LocalizationKeys.verifyNumber.rawValue.localizeString()
        messageLabel.text = LocalizationKeys.optMessage.rawValue.localizeString()
        receiveLabel.text = LocalizationKeys.didnotReceiveCode.rawValue.localizeString()
        resendButton.setTitle(LocalizationKeys.resend.rawValue.localizeString(), for: .normal)
        verifyButton.setTitle(LocalizationKeys.verify.rawValue.localizeString(), for: .normal)
        backButton.setImage(UIImage(named: Helper.shared.isRTL() ? "back-ar" : "back-en"), for: .normal)
    }
}
