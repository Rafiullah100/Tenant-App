//
//  PropertyViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/12/24.
//

import UIKit
import Dispatch
class PropertyViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tenantValueLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
    @IBOutlet weak var flatValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
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
    
    
    private var complaintType: OwnerComplaintType = .new
    private var viewModel = PropertyViewModel()
    private var isLoading = true
    var dispatchGroup: DispatchGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        
        searchTextField.delegate = self
        searchView.clipsToBounds = true
        flatLabel.text = LocalizationKeys.flats.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        propertyLabel.text = LocalizationKeys.properties.rawValue.localizeString()
        titlLabel.text = LocalizationKeys.myProperties.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchByTitle.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.animateSpinner()
        networkingCall()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadProperties), name: Notification.Name(Constants.reloadProperties), object: nil)
    }
    
    func networkingCall(){
        dispatchGroup = DispatchGroup()
        dispatchGroup?.enter()
        viewModel.getProperties(search: searchTextField.text ?? "")
        dispatchGroup?.enter()
        viewModel.getProfile()
        
        viewModel.propertyList.bind { [weak self] list in
            guard let list = list else {return}
            print(list)
            self?.dispatchGroup?.leave()
        }
        
        viewModel.profile.bind { [weak self] profile in
            guard let profile = profile else {return}
            print(profile)
            self?.dispatchGroup?.leave()
        }
        
        dispatchGroup?.notify(queue: .main) {
            self.stopAnimation()
            self.isLoading = false
            self.tableView.reloadData()
            self.updateUI()
        }
    }
    
    @objc private func reloadProperties(){
        viewModel.propertyList.bind { [weak self] list in
            guard let _ = list else {return}
            self?.stopAnimation()
            self?.tableView.reloadData()
        }
        self.animateSpinner()
        viewModel.getProperties(search: searchTextField.text ?? "")
    }
    
    private func updateUI(){
        self.nameLabel.text = viewModel.getName()
        imageView.sd_setImage(with: URL(string: Route.baseUrl + viewModel.getPicture()), placeholderImage: UIImage(named: "User"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.propertyValueLabel.text = "\(UserDefaults.standard.ownerTotolProperties ?? 0)"
        self.tenantValueLabel.text = "\(UserDefaults.standard.ownerTotolTenants ?? 0)"
        self.flatValueLabel.text = "\(UserDefaults.standard.ownerTotolFlats ?? 0)"
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        Switcher.gotoAddProperty(delegate: self)
    }
}

extension PropertyViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        
        if viewModel.getPropertiesCount() == 0{
            self.tableView.setEmptyView(LocalizationKeys.noPropertyToShow.rawValue.localizeString())
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
        guard let detail = viewModel.getProperty(at: indexPath.row) else { return }
        Switcher.gotoPropertyDetail(delegate: self, propertyDetail: detail)
    }
}

extension PropertyViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        reloadProperties()
        return true
    }
}
