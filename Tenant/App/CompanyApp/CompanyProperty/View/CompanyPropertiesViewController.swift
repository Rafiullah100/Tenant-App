//
//  CompanyPropertiesViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/7/24.
//

import UIKit

class CompanyPropertiesViewController: BaseViewController {
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "PropertyTableViewCell", bundle: nil), forCellReuseIdentifier: PropertyTableViewCell.cellReuseIdentifier())
        }
    }
    private var viewModel = CompanyPropertyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        searchTextField.delegate = self
        searchView.clipsToBounds = true
        titlLabel.text = LocalizationKeys.propertiesAssigned.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchByTitle.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        nameLabel.text = UserDefaults.standard.name
        contactLabel.text = UserDefaults.standard.mobile
        
        viewModel.propertyList.bind { [weak self] list in
            guard let _ = list else {return}
            self?.stopAnimation()
            self?.tableView.reloadData()
        }
        callAPI()
    }
    
    private func callAPI(){
        self.animateSpinner()
        viewModel.getProperties(search: searchTextField.text ?? "")
    }
}

extension CompanyPropertiesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPropertiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyTableViewCell.cellReuseIdentifier(), for: indexPath) as! PropertyTableViewCell
        cell.property = viewModel.getProperty(at: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let property = viewModel.getProperty(at: indexPath.row) else { return }
        Switcher.gotoCompanyPropertyDetail(delegate: self, property: property)
    }
}

extension CompanyPropertiesViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callAPI()
        return true
    }
}


