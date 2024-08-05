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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false

        searchView.clipsToBounds = true
        titlLabel.text = LocalizationKeys.maintenanceCompanyManagement.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchMaintenanceCompany.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        type = .company
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension CompanyManagmentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCardTableViewCell.cellReuseIdentifier(), for: indexPath) as! CompanyCardTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
