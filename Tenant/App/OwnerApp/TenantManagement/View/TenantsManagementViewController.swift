//
//  TenantsManagementViewController.swift
//  Raabt2
//
//  Created by Ngc on 13/07/2024.
//

import UIKit

class TenantsManagementViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
//    @IBOutlet weak var cardCollectionView: UICollectionView!{
//        didSet{
//            cardCollectionView.register(TenantCollectionViewCell.nib(), forCellWithReuseIdentifier: TenantCollectionViewCell.cellReuseIdentifier())
//            cardCollectionView.delegate = self
//            cardCollectionView.dataSource = self
//        }
//    }
    @IBOutlet weak var propertyValueLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "TenantMngmentTableViewCell", bundle: nil), forCellReuseIdentifier: TenantMngmentTableViewCell.cellReuseIdentifier())
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var property: String?

    let viewModel = PropertyTenantsViewModel()
    var propertyID: Int?
    private var isLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        viewControllerTitle = LocalizationKeys.tenantManagement.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchTenants.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        type = .company
        propertyValueLabel.text = property ?? ""

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        
        viewModel.tenantList.bind { tenantList in
            DispatchQueue.main.async {
                guard let _ = tenantList else{return}
                self.stopAnimation()
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
        
        viewModel.delete.bind { delete in
            guard let delete = delete else{return}
            if delete.success == true{
                DispatchQueue.main.async {
                    self.stopAnimation()
                    ToastManager.shared.showToast(message: delete.message ?? "")
                    self.networkingCall()
                }
            }
            else{
                self.showAlert(message: delete.message ?? "")
            }
        }
        
        networkingCall()
    }
    
    @objc private func networkingCall()  {
        self.animateSpinner()
        viewModel.getList(propertyID: propertyID ?? 0, search: searchTextField.text ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchView.layer.masksToBounds = true
        searchView.clipsToBounds = true
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        if viewModel.getCount() == 0{
            self.tableView.setEmptyView("No Tenants Found!")
        }
        else{
            self.tableView.backgroundView = nil
        }
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TenantMngmentTableViewCell.cellReuseIdentifier(), for: indexPath) as! TenantMngmentTableViewCell
        cell.tenants = viewModel.getTenant(at: indexPath.row)
        cell.delete = {
            self.animateSpinner()
            self.viewModel.deleteTenant(flatID: self.viewModel.getFlatID(at: indexPath.row))
        }
        return cell
    }
    

}

extension TenantsManagementViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        networkingCall()
        return true
    }
}
