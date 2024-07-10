//
//  LanguageViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/10/24.
//

import UIKit

class LanguageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func englishButton(_ sender: Any) {
        setLanguage(code: .en, language: .english, isRTL: 0)
    }
    
    @IBAction func arabicButton(_ sender: Any) {
        setLanguage(code: .ar, language: .arabic, isRTL: 1)
    }
    
    func setLanguage(code: AppLanguagecode, language: AppLanguage, isRTL: Int) {
        UserDefaults.standard.isRTL = isRTL
        UserDefaults.standard.selectedLanguage = language.rawValue
        UserDefaults.standard.languageCode = code.rawValue
        UIView.appearance().semanticContentAttribute = isRTL == 1 ? .forceRightToLeft : .forceLeftToRight
        Switcher.gotoMaintenanceScreen(delegate: self)
    }

}
