//
//  ViewController.swift
//  Raabt
//
//  Created by Ngc on 27/06/2024.
//

import UIKit

class TenantHomeViewController: BaseViewController , UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var historyTableView: UITableView!{
        didSet{
            historyTableView.delegate = self
            historyTableView.dataSource = self
            historyTableView.register(UINib(nibName: "TenantTableViewCell", bundle: nil), forCellReuseIdentifier: TenantTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var flatView: UIStackView!
    @IBOutlet weak var buildingValueLabel: UILabel!
    @IBOutlet weak var flatValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet weak var propertyView: UIView!
    var isLoading = true
    var isRecent = true
    private var viewModel = TenantComplaintViewModel()
    
    let refreshControl = UIRefreshControl()
    private var complaintType: TenantComplaintType = .recent

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.token ?? "")
        buildingLabel.text = "\(LocalizationKeys.buildingNo.rawValue.localizeString())"
        flatLabel.text = "\(LocalizationKeys.flatNo.rawValue.localizeString())"
        
        recentButton.setTitle(LocalizationKeys.current.rawValue.localizeString(), for: .normal)
        historyButton.setTitle(LocalizationKeys.completed.rawValue.localizeString(), for: .normal)

        historyTableView.showsVerticalScrollIndicator = false
        
        self.historyTableView.rowHeight = UITableView.automaticDimension
        self.historyTableView.estimatedRowHeight = 44.0
        
        viewModel.tenantResidence.bind { [unowned self] residence in
            guard let _ = residence else {return}
            self.savePropertiesAndFlat()
            updateUI()
        }
        viewModel.getTenantResidence()
        
        callAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(callAPI), name: NSNotification.Name(Constants.reloadTenantComplaints), object: nil)
        
        refreshControl.addTarget(self, action: #selector(callAPI), for: .valueChanged)
        historyTableView.refreshControl = refreshControl
    }
    
    @objc private func callAPI(){
        viewModel.complaintList.bind { [unowned self] list in
            guard let _ = list else {return}
            self.historyTableView.refreshControl?.endRefreshing()
            self.isLoading = false
            self.stopAnimation()
            self.historyTableView.reloadData()
        }
        
        self.animateSpinner()
        viewModel.getComplaints()
    }
    
    private func updateUI(){
        self.flatView.isHidden = viewModel.isVilla()
        self.buildingLabel.text = viewModel.getBuildingType()
        self.buildingValueLabel.text = viewModel.getBuilding()
        self.flatValueLabel.text = viewModel.getTenantFlatNo()
        nameLabel.text = UserDefaults.standard.name
        propertyView.isHidden = !viewModel.isPropertyAssigned()
    }
    
    @IBAction func recentBtnAction(_ sender: Any) {
        complaintType = .recent
        setupButton(complaintType: .recent)
    }
    
    @IBAction func historyBtnActgion(_ sender: Any) {
        complaintType = .history
        setupButton(complaintType: .history)
    }
    
    private func setupButton(complaintType: TenantComplaintType = .recent){
        historyTableView.reloadData()
        recentButton.backgroundColor = CustomColor.grayColor.color
        historyButton.backgroundColor = CustomColor.grayColor.color
        switch complaintType {
        case .recent:
            recentButton.backgroundColor = CustomColor.appColor.color
        case .history:
            historyButton.backgroundColor = CustomColor.appColor.color
        }
    }
        
    private func savePropertiesAndFlat(){
        UserDefaults.standard.propertyIDIfTenant = viewModel.propertyIDIfTenant()
        UserDefaults.standard.flatIDIfTenant = viewModel.flatIDIfTenant()
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        if viewModel.isPropertyAssigned() && viewModel.isCompanyAssigned(){
            Switcher.gotoAddComplaintScreen(delegate: self, addComplaintType: .tenant)
        }
        else if viewModel.isPropertyAssigned() == false{
            showAlert(message: "No property is assigned to you!, Please contact with your owner")
        }
        else if viewModel.isCompanyAssigned() == false {
            showAlert(message: "No company is assigned to your property!, Please contact with your owner")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func contactButtonAction(_ sender: Any) {
        Switcher.gotoMenu(delegate: self, menuType: .tenant)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        let count = complaintType == .recent ? viewModel.getRecentCount() : viewModel.getHistoryCount()
        if count == 0{
            self.historyTableView.setEmptyView()
        }
        else{
            self.historyTableView.backgroundView = nil
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: TenantTableViewCell.cellReuseIdentifier(), for: indexPath) as! TenantTableViewCell
        cell.complaint = complaintType == .recent ? viewModel.getRecentComplaint(index: indexPath.row) : viewModel.getHistoryComplaint(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if complaintType == .recent{
            Switcher.gotoTenantCompletedDetailScreen(delegate: self, complaintID: viewModel.getRecentID(index: indexPath.row))
        }
        else{
            Switcher.gotoTenantCompletedDetailScreen(delegate: self, complaintID: viewModel.getHistoryID(index: indexPath.row))
        }
    }
}


