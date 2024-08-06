//
//  BaseViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/31/24.
//

import UIKit
enum ViewControllerType {
    case otpBack
    case tenant
    case company
}

class BaseViewController: UIViewController {
    var type: ViewControllerType = .otpBack
    var titleLabel: UILabel?
    
    var viewControllerTitle: String? {
        didSet {
            titleLabel?.text = viewControllerTitle ?? ""
            switch type {
            case .otpBack, .tenant, .company:
                addCenterLabel()
            default:
                break
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.isFirstLoad = true
    }


    func addCenterLabel() {
        titleLabel = UILabel()
        if let titleLabel = titleLabel {
            print(viewControllerTitle ?? "")
            titleLabel.text = viewControllerTitle ?? ""
            titleLabel.font = UIFont(name: Constants.fontNameBold, size: 20)
            titleLabel.textColor = .black
            self.navigationItem.titleView = titleLabel
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        solidNavigationBar(color: .clear)
        switch type {
        case .otpBack:
            setupBackButtonWithTitle()
        case .tenant:
            setupHomeBarButtonItems()
        case .company:
            setupBackButtonForCompany()
        }
    }
    
    func solidNavigationBar(color: UIColor) {
        navigationController?.navigationBar.isTranslucent = true
       if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
           appearance.backgroundColor = color
           
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
           navigationController?.navigationBar.frame = CGRect(x: navigationController?.navigationBar.frame.origin.x ?? 0, y: navigationController?.navigationBar.frame.origin.y ?? 0, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
           //y = 20
        }else{
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.frame = CGRect(x: navigationController?.navigationBar.frame.origin.x ?? 0, y: navigationController?.navigationBar.frame.origin.y ?? 0, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
        }
    }
    
    func setupHomeBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        navigationItem.rightBarButtonItems = []
        homeButtons()
    }
    
    func setupBackButtonWithTitle() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addBackButtonWithTitle()
    }
    
    func setupBackButtonForCompany() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addBackButtonForCompany()
    }
    
    func addBackButtonWithTitle() {
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        leftButton.image = Helper.shared.isRTL() ? UIImage(named: "back-ar") : UIImage(named: "back-en")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func addBackButtonForCompany() {
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        leftButton.image = Helper.shared.isRTL() ? UIImage(named: "back-arrow-ar") : UIImage(named: "back-arrow-en")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    
    func setupHomeButtons() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addHomeButtons()
        addCenterLabel()
    }
    
    func setupDetailButtons() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addDetailButtons()
    }

    
    func addArrowBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        backButton.image = nil
        backButton.image = Helper.shared.isRTL() ? UIImage(named: "back-arrow-rtl") : UIImage(named: "back-arrow")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func addHomeButtons() {
        let sideMenuButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(menuButtonAction))
//        searchButton.image = UIImage(named: "search-icon")
//        sideMenuButton.image = UIImage(named: "side-menu-icon")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = sideMenuButton
//        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func menuButtonAction(){
//         let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
//        menu.delegate = self
//        menu.leftSide = Helper.shared.semantic(AppLanguage(rawValue: UserDefaults.standard.selectedLanguage ?? "") ?? .english) == .forceRightToLeft ? false : true
//
//        menu.leftSide = Helper.shared.semantic(AppLanguage(rawValue: UserDefaults.standard.selectedLanguage ?? "") ?? .english) == .forceRightToLeft ? false : true
//        menu.menuWidth = self.view.frame.size.width * 0.80
//        present(menu, animated: true, completion: nil)
    }
    
    func addDetailButtons(isWhite: Bool = true) {
//        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
//        let rightButton = UIBarButtonItem(title: LocalizationKeys.viewSource.rawValue.localizeString(), style: .plain, target: self, action: #selector(sourceButtonAction))
//        rightButton.tintColor = .white
//        if isWhite == true {
//            leftButton.image = Helper.shared.isRTL() ? UIImage(named: "white-arrow-back-rtl") : UIImage(named: "white-arrow-back")
//        }
//        else{
//            leftButton.image = Helper.shared.isRTL() ? UIImage(named: "back-arrow-rtl") : UIImage(named: "back-arrow")
//        }
//        self.navigationController?.navigationItem.hidesBackButton = true
//        self.navigationItem.leftBarButtonItem = leftButton
//        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func sourceButtonAction(){
//        actionBlock?()
    }
    
    func homeButtons() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backAction))
        let profileButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(menuButtonAction))
        profileButton.image = UIImage(named: "User")
        backButton.image = UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = profileButton
    }
    
    @objc func backButtonAction() {
        
            if let _ = navigationController?.popViewController(animated: true) {
            } else {
                navigationController?.tabBarController?.selectedIndex = 0
                dismiss(animated: true, completion: nil)
            }
    }
    
    
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backAction() {
        if let _ = navigationController?.popViewController(animated: true) {
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
 
}

