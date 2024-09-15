//
//  CompanyManagmentViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/21/24.
//

import UIKit
import SDWebImage
class CompanyManagmentViewController: BaseViewController {

    
    @IBOutlet weak var propertyValueLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CompanyCardTableViewCell", bundle: nil), forCellReuseIdentifier: CompanyCardTableViewCell.cellReuseIdentifier())
        }
    }
    private var viewModel = CompanyViewModel()
    var propertyID: Int?
    var property: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        searchTextField.delegate = self
        searchView.clipsToBounds = true
        viewControllerTitle = LocalizationKeys.maintenanceCompanyManagement.rawValue.localizeString()
        propertyValueLabel.text = property ?? ""
        searchTextField.placeholder =  LocalizationKeys.searchMaintenanceCompany.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        type = .company
        viewModel.companiesList.bind { list in
            guard let _ = list else{return}
            self.stopAnimation()
            self.tableView.reloadData()
        }
        callAPI()
        viewModel.assign.bind { assign in
            guard let assign = assign else{return}
            self.stopAnimation()
            if assign.success == true{
                DispatchQueue.main.async {
                    ToastManager.shared.showToast(message: assign.message ?? "")
                    NotificationCenter.default.post(name: Notification.Name(Constants.reloadProperties), object: nil)
                    Switcher.gotoOwnerProperty(delegate: self)
                    self.callAPI()
                }
            }
            else{
                ToastManager.shared.showToast(message: assign.message ?? "")
            }
        }
    }
    
    private func callAPI(){
        self.animateSpinner()
        viewModel.getList(propertyID: propertyID ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension CompanyManagmentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCardTableViewCell.cellReuseIdentifier(), for: indexPath) as! CompanyCardTableViewCell
        cell.nameLabel.text = viewModel.getName(at: indexPath.row)
        cell.assignButton.setTitle(viewModel.isAssigned(at: indexPath.row), for: .normal)
        cell.iconView.sd_setImage(with: URL(string: Route.baseUrl + viewModel.getIcon(at: indexPath.row)), placeholderImage: UIImage(named: "PlaceholderImage"))
        cell.assign = { [weak self] in
            if let companyID = self?.viewModel.getCompanyID(at: indexPath.row) {
                self?.animateSpinner()
                self?.viewModel.assignToProperty(companyID: companyID, propertyID: self?.propertyID ?? 0)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

}

extension CompanyManagmentViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callAPI()
        return true
    }
}
