//
//  PropertyViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/12/24.
//

import UIKit
import Dispatch
class PropertyViewController: BaseViewController {

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

        searchView.clipsToBounds = true
        flatLabel.text = LocalizationKeys.flats.rawValue.localizeString() + "   25"
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        propertyLabel.text = LocalizationKeys.properties.rawValue.localizeString() + "   Building"
        titlLabel.text = LocalizationKeys.myProperties.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchByTitle.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        self.animateSpinner()
        networkingCall()
    }
    
    func networkingCall(){
        dispatchGroup = DispatchGroup()
        dispatchGroup?.enter()
        viewModel.getProperties()
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
    
    private func updateUI(){
        self.propertyValueLabel.text = "\(viewModel.getTotalProperty())"
        self.tenantValueLabel.text = "\(viewModel.getTenantCount())"
        self.flatValueLabel.text = "\(viewModel.getFlatCount())"
        self.nameLabel.text = viewModel.getName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

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
            self.tableView.setEmptyView("No Property to Show")
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let type: PropertyType = indexPath.row % 2 == 0 ? .building : .villa
        Switcher.gotoPropertyDetail(delegate: self, propertyType: viewModel.getBuildingType(at: indexPath.row))
    }
}

extension PropertyViewController: AddPropertyDelegate{
    func propertyAdded() {
        self.animateSpinner()
        networkingCall()
    }
}
