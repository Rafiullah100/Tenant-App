//
//  ViewController.swift
//  Raabt
//
//  Created by Ngc on 27/06/2024.
//

import UIKit



class SelfHomeViewController: BaseViewController , UITableViewDataSource , UITableViewDelegate {
  @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var homeButtonView: UIView!
    @IBOutlet weak var addressValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var historyTableView: UITableView!{
        didSet{
            historyTableView.delegate = self
            historyTableView.dataSource = self
            historyTableView.register(UINib(nibName: "SelfHomeTableViewCell", bundle: nil), forCellReuseIdentifier: SelfHomeTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    
    var isLoading = true
    var isRecent = true
    private var viewModel = TenantComplaintViewModel()
    var complaintType: SelfComplaintType = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.showsVerticalScrollIndicator = false
        self.historyTableView.rowHeight = UITableView.automaticDimension
        self.historyTableView.estimatedRowHeight = 44.0
        self.nameLabel.text = UserDefaults.standard.name
        
        newButton.setTitle(LocalizationKeys.current.rawValue.localizeString(), for: .normal)
        historyButton.setTitle(LocalizationKeys.completed.rawValue.localizeString(), for: .normal)
        homeButton.setTitle(LocalizationKeys.selectHome.rawValue.localizeString(), for: .normal)
        viewModel.complaintList.bind { [unowned self] list in
            guard let _ = list else {return}
            self.isLoading = false
            self.stopAnimation()
            self.historyTableView.reloadData()
        }
        
        loadComplaints()
        NotificationCenter.default.addObserver(self, selector: #selector(loadComplaints), name: Notification.Name(Constants.reloadSelfComplaints), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.addressValueLabel.text = UserDefaults.standard.currentHome
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")), placeholderImage: UIImage(named: "User"))
        
        viewModel.tenantResidence.bind { [unowned self] residence in
            guard let _ = residence else {return}
            self.configureHomeButton()
        }
        viewModel.getTenantResidence()
    }
    
    private func configureHomeButton(){
        self.homeButtonView.isHidden = viewModel.isHomeButtonHide()
    }
    
    @objc private func loadComplaints(){
        self.animateSpinner()
        viewModel.getComplaints()
    }

    @IBAction func homeBtnAction(_ sender: Any) {
//        guard UserDefaults.standard.propertyIDIfTenant == 0 && UserDefaults.standard.flatIDIfTenant == 0 || UserDefaults.standard.propertyIDIfTenant == nil && UserDefaults.standard.flatIDIfTenant == nil else{
//            return
//        }
        Switcher.gotoSelfList(delegate: self)
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        isRecent = true
        complaintType = .new
        setupButton(complaintType: .new)
    }
    
    @IBAction func historyBtnAction(_ sender: Any) {
        isRecent = false
        complaintType = .history
        setupButton(complaintType: .history)
    }
    
    private func setupButton(complaintType: SelfComplaintType = .new){
        historyTableView.reloadData()
        newButton.backgroundColor = CustomColor.grayColor.color
        historyButton.backgroundColor = CustomColor.grayColor.color

        switch complaintType {
        case .new:
            newButton.backgroundColor = CustomColor.appColor.color
        case .history:
            historyButton.backgroundColor = CustomColor.appColor.color
        }
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        guard UserDefaults.standard.propertyIDIfTenant != nil && UserDefaults.standard.flatIDIfTenant != nil else{
            showAlert(message: LocalizationKeys.firstSelectPropertyThenAddComplaint.rawValue.localizeString())
            return
        }
        Switcher.gotoAddComplaintScreen(delegate: self, addComplaintType: .ownerSelf)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        let count = isRecent ? viewModel.getRecentCount() : viewModel.getHistoryCount()
        if count == 0{
            self.historyTableView.setEmptyView()
        }
        else{
            self.historyTableView.backgroundView = nil
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: SelfHomeTableViewCell.cellReuseIdentifier(), for: indexPath) as! SelfHomeTableViewCell
        cell.complaint = isRecent ? viewModel.getRecentComplaint(index: indexPath.row) : viewModel.getHistoryComplaint(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if complaintType == .new{
            Switcher.gotoTenantCompletedDetailScreen(delegate: self, complaintID: viewModel.getRecentID(index: indexPath.row))
            print(viewModel.getRecentID(index: indexPath.row))
        }
        else{
            Switcher.gotoTenantCompletedDetailScreen(delegate: self, complaintID: viewModel.getHistoryID(index: indexPath.row))
            print(viewModel.getHistoryID(index: indexPath.row))
        }
    }
}


