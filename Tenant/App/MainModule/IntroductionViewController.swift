//
//  IntroductionViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit

class IntroductionViewController: UIViewController {
  
    @IBOutlet weak var curveImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = LocalizationKeys.welcome.rawValue.localizeString()
        sloganLabel.text = LocalizationKeys.slogan.rawValue.localizeString()
        nextButton.setImage(UIImage(named: Helper.shared.isRTL() ? "next-ar" : "next-en"), for: .normal)
        curveImageView.image = UIImage(named: Helper.shared.isRTL() ? "curved-bg-ar" : "curved-bg-en")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        Switcher.gotoSigninScreen(delegate: self)
    }
}
