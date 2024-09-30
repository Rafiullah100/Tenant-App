//
//  MenuViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 9/25/24.
//

import UIKit
struct MenuItem {
    let name: String
    let image: String
    
}
class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: MenuTableViewCell.cellReuseIdentifier())
        }
    }
    
    let tenantMenuItems = [MenuItem(name: LocalizationKeys.profile.rawValue.localizeString(), image: ""), MenuItem(name: LocalizationKeys.contacts.rawValue.localizeString(), image: ""), MenuItem(name: LocalizationKeys.language.rawValue.localizeString(), image: Helper.shared.isRTL() ? "left-arrow" : "right-arrow"), MenuItem(name: LocalizationKeys.logout.rawValue.localizeString(), image: "")]
    
    let languageMenuItems = [MenuItem(name: LocalizationKeys.english.rawValue.localizeString(), image: "tick-green"), MenuItem(name: LocalizationKeys.arabic.rawValue.localizeString(), image: "tick-green")]
    var menuType: MenuType = .tenant
    var menuTypeAfterLanguage: MenuType?
    
    let ownerMenuItems = [MenuItem(name: LocalizationKeys.profile.rawValue.localizeString(), image: ""), MenuItem(name: LocalizationKeys.logout.rawValue.localizeString(), image: "")]

    let workerMenuItems = [MenuItem(name: LocalizationKeys.profile.rawValue.localizeString(), image: ""), MenuItem(name: LocalizationKeys.language.rawValue.localizeString(), image: Helper.shared.isRTL() ? "left-arrow" : "right-arrow"), MenuItem(name: LocalizationKeys.logout.rawValue.localizeString(), image: "")]


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        menuTypeAfterLanguage = menuType
        reload()
    }
    
    private func reload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.tableViewHeight.constant = self.tableView.contentSize.height
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func logout(){
        UserDefaults.clean(exceptKeys: [UserDefaults.userdefaultsKey.isLaunchedFirstTime.rawValue, UserDefaults.userdefaultsKey.languageCode.rawValue, UserDefaults.userdefaultsKey.selectedLanguage.rawValue, UserDefaults.userdefaultsKey.isRTL.rawValue])
        Switcher.logout(delegate: self)
    }
    
    private func handleTenantSelection(indexPath: IndexPath){
        if indexPath.row == 0{
            Switcher.gotoProfile(delegate: self, userType: .tenant)
        }
        else if indexPath.row == 2{
            self.menuType = .language
            self.reload()
        }
        else if indexPath.row == 3{
            self.logout()
        }
        else if indexPath.row == 1{
            Switcher.gotoContactList(delegate: self)
        }
    }
    
    private func handleOwnerSelection(indexPath: IndexPath){
        if indexPath.row == 0{
            if menuTypeAfterLanguage == .company{
                Switcher.gotoCompanyProfile(delegate: self)
            }
            else{
                Switcher.gotoProfile(delegate: self, userType: .owner)
            }
        }
        else if indexPath.row == 1{
            self.logout()
        }
    }
    
    private func handleWorkerSelection(indexPath: IndexPath){
        if indexPath.row == 0{
            Switcher.gotoProfile(delegate: self, userType: .worker)
        }
        else if indexPath.row == 1{
            self.menuType = .language
            self.reload()
        }
        else if indexPath.row == 2{
            self.logout()
        }
    }
    
    private func handleLanguageSelection(indexPath: IndexPath){
        if indexPath.row == 0{
            self.view.setLanguage(code: .en, language: .english, isRTL: 0)
        }
        else if indexPath.row == 1{
            self.view.setLanguage(code: .ar, language: .arabic, isRTL: 1)
        }
        if menuTypeAfterLanguage == .tenant{
            Switcher.tenantLanguageChange(delegate: self)
        }
        else if menuTypeAfterLanguage == .worker{
            Switcher.workerLanguageChange(delegate: self)
        }
        else{
            Switcher.changeLanguage(delegate: self)
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch menuType {
        case .tenant:
            return tenantMenuItems.count
        case .language:
            return languageMenuItems.count
        case .owner, .company:
            return ownerMenuItems.count
        case .worker:
            return workerMenuItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.cellReuseIdentifier(), for: indexPath) as! MenuTableViewCell
        let menuItem: MenuItem
        switch menuType {
        case .tenant:
            menuItem = tenantMenuItems[indexPath.row]
        case .language:
            menuItem = languageMenuItems[indexPath.row]
            cell.imgView.isHidden = indexPath.row != Int(UserDefaults.standard.isRTL ?? 0)
        case .owner, .company:
            menuItem = ownerMenuItems[indexPath.row]
        case .worker:
            menuItem = workerMenuItems[indexPath.row]
        }
        cell.label.text = menuItem.name
        cell.imgView.image = UIImage(named: menuItem.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menuType {
        case .tenant:
            self.handleTenantSelection(indexPath: indexPath)
        case .language:
            self.handleLanguageSelection(indexPath: indexPath)
        case .owner, .company:
            self.handleOwnerSelection(indexPath: indexPath)
        case .worker:
            self.handleWorkerSelection(indexPath: indexPath)
        }
    }
}
