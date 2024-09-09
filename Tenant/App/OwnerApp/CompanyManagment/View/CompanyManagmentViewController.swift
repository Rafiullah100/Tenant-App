//
//  CompanyManagmentViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/21/24.
//

import UIKit

class CompanyManagmentViewController: BaseViewController {

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var titlLabel: UILabel!
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
    var buildingNumer: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false

        searchTextField.delegate = self
        searchView.clipsToBounds = true
        viewControllerTitle = LocalizationKeys.maintenanceCompanyManagement.rawValue.localizeString()
        titlLabel.text = buildingNumer ?? ""
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
            self.showAlert(message: assign.message ?? "")
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
        cell.assignButton.setTitle(viewModel.isAssigned(at: indexPath.row) == true ? "Assigned" : "Not Assigned", for: .normal)
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Switcher.gotoCompanyDetail(delegate: self)
//    }
}

extension CompanyManagmentViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callAPI()
        return true
    }
}
