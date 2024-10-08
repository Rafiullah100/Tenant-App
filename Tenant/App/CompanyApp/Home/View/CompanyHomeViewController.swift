//
//  HomeViewController.swift
//  Raabt2
//
//  Created by Ngc on 04/07/2024.
//

import UIKit
import SDWebImage

class CompanyHomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ongoingButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CompanyNewTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            
            tableView.register(UINib(nibName: "CompanyOngoingTableViewCell", bundle: nil), forCellReuseIdentifier: "ongoing")
        }
    }
    private var viewModel = CompanyComplaintViewModel()
    private var isDone = false
    private var complaintType: CompanyComplaintType = .new
    var isLoading = true
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(UserDefaults.standard.token)
        searchView.clipsToBounds = true
        newButton.setTitle(LocalizationKeys.current.rawValue.localizeString(), for: .normal)
        ongoingButton.setTitle(LocalizationKeys.ongoing.rawValue.localizeString(), for: .normal)
        historyButton.setTitle(LocalizationKeys.completed.rawValue.localizeString(), for: .normal)

        searchTextField.placeholder = LocalizationKeys.search.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        tableView.showsVerticalScrollIndicator = false
        viewModel.complaintList.bind { [unowned self] list in
            guard let _ = list else {return}
            self.isLoading = false
            self.stopAnimation()
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            ApiService.shared.registerDeviceTokenForNotificaiton()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: Notification.Name(Constants.reloadCompanyComplaints), object: nil)
        loadData()
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func loadData(){
        self.animateSpinner()
        viewModel.getComplaints(search: searchTextField.text ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        nameLabel.text = UserDefaults.standard.name
        contactLabel.text = UserDefaults.standard.mobile
        profileImageView.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")), placeholderImage: UIImage(named: "User"))
    }
    
    @IBAction func profileBtnAction(_ sender: Any) {
        Switcher.gotoMenu(delegate: self, menuType: .company)
    }
    
    @IBAction func historyBtnAction(_ sender: Any) {
        complaintType = .completed
        setupButton(complaintType: .completed)
    }
    
    @IBAction func ongoingBtnAction(_ sender: Any) {
        complaintType = .ongoing
        setupButton(complaintType: .ongoing)
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        complaintType = .new
        setupButton(complaintType: .new)
    }
    
    private func setupButton(complaintType: CompanyComplaintType = .new){
        tableView.reloadData()
        newButton.backgroundColor = CustomColor.grayColor.color
        ongoingButton.backgroundColor = CustomColor.grayColor.color
        historyButton.backgroundColor = CustomColor.grayColor.color
        switch complaintType {
        case .new:
            newButton.backgroundColor = CustomColor.appColor.color
        case .ongoing:
            ongoingButton.backgroundColor = CustomColor.appColor.color
        case .completed:
            historyButton.backgroundColor = CustomColor.appColor.color
        }
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
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch complaintType {
        case .new:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompanyNewTableViewCell
            cell.complaint = viewModel.getRecentComplaint(index: indexPath.row)
            return cell
        case .ongoing:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ongoing", for: indexPath) as! CompanyOngoingTableViewCell
            cell.complaint = viewModel.getOngoingComplaint(index: indexPath.row)
            return cell
        case .completed:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ongoing", for: indexPath) as! CompanyOngoingTableViewCell
            cell.complaint = viewModel.getHistoryComplaint(index: indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if complaintType == .new{
            Switcher.gotoPendingDetail(delegate: self, complaintID: viewModel.getRecentID(index: indexPath.row))
        }
        else if complaintType == .ongoing{
            Switcher.gotoPendingDetail(delegate: self, complaintID: viewModel.getOngoingID(index: indexPath.row))
        }
        else if complaintType == .completed{
            Switcher.gotoPendingDetail(delegate: self, complaintID: viewModel.getHistoryID(index: indexPath.row))
        }
    }
}


extension CompanyHomeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loadData()
        return true
    }
}
