//
//  AddTenanToFlatViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/18/24.
//

import UIKit

class AddTenanToFlatViewController: BaseViewController {

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
    private var viewModel = AddTenantToFlatViewModel()
    var flatID: Int?
    var isLoading = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false

        searchView.clipsToBounds = true
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        type = .company
        tableView.setEmptyView("Search Tenants by name or contacts")
        viewModel.tenantList.bind { list in
            guard let _ = list else{return}
            self.isLoading = false
            self.stopAnimation()
            self.tableView.reloadData()
        }
        searchTextField.delegate = self

        viewModel.assign.bind { assign in
            guard let assign = assign else{return}
            self.stopAnimation()
            self.showAlert(message: assign.message ?? "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension AddTenanToFlatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        
        if viewModel.getCount() == 0{
            self.tableView.setEmptyView("No tenant found.")
        }
        else{
            self.tableView.backgroundView = nil
        }
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCardTableViewCell.cellReuseIdentifier(), for: indexPath) as! CompanyCardTableViewCell
        cell.nameLabel.text = viewModel.getName(at: indexPath.row)
        
        cell.assign = { [weak self] in
            if let tenantID = self?.viewModel.getTenantID(at: indexPath.row) {
                self?.animateSpinner()
                self?.viewModel.assignToTenant(flatID: self?.flatID ?? 0, tenantID:tenantID)
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

extension AddTenanToFlatViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        self.animateSpinner()
        viewModel.getList(search: textField.text ?? "")
            return true
        }
}
