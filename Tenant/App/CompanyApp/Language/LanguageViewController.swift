//
//  LanguageViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/10/24.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var chooseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseLabel.text = LocalizationKeys.chooseLanguage.rawValue.localizeString()
    }
    
    @IBAction func englishButton(_ sender: Any) {
        self.view.setLanguage(code: .en, language: .english, isRTL: 0)
        Switcher.companyLanguageChange(delegate: self)
    }
    
    @IBAction func arabicButton(_ sender: Any) {
        self.view.setLanguage(code: .ar, language: .arabic, isRTL: 1)
        Switcher.companyLanguageChange(delegate: self)
    }
    
//    func setLanguage(code: AppLanguagecode, language: AppLanguage, isRTL: Int) {
//        UserDefaults.standard.isRTL = isRTL
//        UserDefaults.standard.selectedLanguage = language.rawValue
//        UserDefaults.standard.languageCode = code.rawValue
//        UIView.appearance().semanticContentAttribute = isRTL == 1 ? .forceRightToLeft : .forceLeftToRight
//        Switcher.gotoCompanyScreen(delegate: self)
//    }
}
