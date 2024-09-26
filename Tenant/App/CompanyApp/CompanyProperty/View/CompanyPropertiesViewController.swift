//
//  CompanyPropertiesViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/7/24.
//

import UIKit
import SDWebImage
class CompanyPropertiesViewController: BaseViewController {
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

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
    private var isLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        searchTextField.delegate = self
        searchView.clipsToBounds = true
        titlLabel.text = LocalizationKeys.propertiesAssigned.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchByTitle.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        viewModel.propertyList.bind { [weak self] list in
            guard let _ = list else {return}
            self?.isLoading = false
            self?.stopAnimation()
            self?.tableView.reloadData()
        }
        callAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        nameLabel.text = UserDefaults.standard.name
        contactLabel.text = UserDefaults.standard.mobile
        profileImageView.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")), placeholderImage: UIImage(named: "User"))
    }
    
    private func callAPI(){
        self.animateSpinner()
        viewModel.getProperties(search: searchTextField.text ?? "")
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        Switcher.gotoMenu(delegate: self, menuType: .company)
    }
    @IBAction func profileBtnAction(_ sender: Any) {
        Switcher.gotoCompanyProfile(delegate: self)
    }
}

extension CompanyPropertiesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        
        if viewModel.getPropertiesCount() == 0{
            self.tableView.setEmptyView("No Property assigned yet.")
        }
        else{
            self.tableView.backgroundView = nil
        }
        return viewModel.getPropertiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyTableViewCell.cellReuseIdentifier(), for: indexPath) as! PropertyTableViewCell
        cell.property = viewModel.getProperty(at: indexPath.row)
        return cell
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


