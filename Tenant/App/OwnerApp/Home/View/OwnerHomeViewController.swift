//
//  HomeViewController.swift
//  Raabt2
//
//  Created by Ngc on 04/07/2024.
//

import UIKit
import Dispatch


class OwnerHomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tenantValueLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
    @IBOutlet weak var flatValueLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var rejectedButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ongoingButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "OwnerHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    
    private var isDone = false
    private var complaintType: OwnerComplaintType = .new
    private var viewModel = OwnerComplaintViewModel()
    private var isLoading = true
    var dispatchGroup: DispatchGroup?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        print(UserDefaults.standard.token)
        print(UserDefaults.standard.userID)

        searchView.clipsToBounds = true
        newButton.setTitle(LocalizationKeys.new.rawValue.localizeString(), for: .normal)
        ongoingButton.setTitle(LocalizationKeys.ongoing.rawValue.localizeString(), for: .normal)
        searchTextField.placeholder = LocalizationKeys.search.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        setupButton(complaintType: .new)
        
        self.animateSpinner()
        networkingCall()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadComplaints), name: Notification.Name(Constants.reloadOwnerComplaints), object: nil)
    }
    
    private func networkingCall(){

        dispatchGroup = DispatchGroup()
        dispatchGroup?.enter()
        viewModel.getComplaints()
        dispatchGroup?.enter()
        viewModel.getProfile()
        
        viewModel.complaintList.bind { [weak self] list in
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
    
    @objc private func reloadComplaints(){
        viewModel.complaintList.bind { [weak self] list in
            guard let _ = list else {return}
            self?.stopAnimation()
            self?.tableView.reloadData()
        }
        
        self.animateSpinner()
        viewModel.getComplaints()
    }
    
    private func updateUI(){
        self.propertyValueLabel.text = "\(viewModel.getPropertiesCount())"
        self.tenantValueLabel.text = "\(viewModel.getTenantCount())"
        self.flatValueLabel.text = "\(viewModel.getFlatCount())"
        self.nameLabel.text = viewModel.getName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        isDone.toggle()
        doneButton.setImage(UIImage(named: isDone ? "tick-green" : "tick-gray"), for: .normal)
        setupButton(complaintType: .completed)
    }
    
    @IBAction func rejectedButtonAction(_ sender: Any) {
        setupButton(complaintType: .rejected)
    }
    
    @IBAction func ongoingBtnAction(_ sender: Any) {
        setupButton(complaintType: .ongoing)
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        setupButton(complaintType: .new)
    }
    
    private func setupButton(complaintType: OwnerComplaintType = .new){
        newButton.backgroundColor = CustomColor.grayColor.color
        ongoingButton.backgroundColor = CustomColor.grayColor.color
        rejectedButton.backgroundColor = CustomColor.grayColor.color
        
        switch complaintType {
        case .new:
            self.complaintType = .new
            newButton.backgroundColor = CustomColor.appColor.color
        case .ongoing:
            self.complaintType = .ongoing
            ongoingButton.backgroundColor = CustomColor.appColor.color
        case .rejected:
            self.complaintType = .rejected
            rejectedButton.backgroundColor = CustomColor.appColor.color
        case .completed:
            self.complaintType = .completed
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        switch complaintType {
        case .new:
            if viewModel.getRecentCount() == 0{
                self.tableView.setEmptyView()
            }
            else{
                self.tableView.backgroundView = nil
            }
            return viewModel.getRecentCount()
        case .ongoing:
            if viewModel.getOngoingCount() == 0{
                self.tableView.setEmptyView()
            }
            else{
                self.tableView.backgroundView = nil
            }
            return viewModel.getOngoingCount()
        case .completed:
            if viewModel.getHistoryCount() == 0{
                self.tableView.setEmptyView()
            }
            else{
                self.tableView.backgroundView = nil
            }
            return viewModel.getHistoryCount()
        case .rejected:
            if viewModel.getRejectedCount() == 0{
                self.tableView.setEmptyView()
            }
            else{
                self.tableView.backgroundView = nil
            }
            return viewModel.getRejectedCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OwnerHomeTableViewCell
        switch complaintType {
        case .new:
            cell.complaint = viewModel.getRecentComplaint(index: indexPath.row)
        case .ongoing:
            cell.complaint = viewModel.getOngoingComplaint(index: indexPath.row)
        case .rejected:
            cell.complaint = viewModel.getRejectedComplaint(index: indexPath.row)
        case .completed:
            cell.complaint = viewModel.getHistoryComplaint(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {            
        let complaintID: Int?
        switch complaintType {
        case .new:
            complaintID = viewModel.getRecenttID(index: indexPath.row)
        case .ongoing:
            complaintID = viewModel.getOngoingID(index: indexPath.row)
        case .rejected:
            complaintID = viewModel.getRejectedID(index: indexPath.row)
        case .completed:
            complaintID = viewModel.getHistoryID(index: indexPath.row)
        }
        Switcher.gotoOwnerDetail(delegate: self, complaintType: complaintType, complaintID: complaintID ?? 0)
    }
}