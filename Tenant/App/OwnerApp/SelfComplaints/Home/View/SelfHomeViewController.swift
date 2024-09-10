//
//  ViewController.swift
//  Raabt
//
//  Created by Ngc on 27/06/2024.
//

import UIKit



class SelfHomeViewController: BaseViewController , UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var addressValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var historyTableView: UITableView!{
        didSet{
            historyTableView.delegate = self
            historyTableView.dataSource = self
            historyTableView.register(UINib(nibName: "SelfHomeTableViewCell", bundle: nil), forCellReuseIdentifier: SelfHomeTableViewCell.cellReuseIdentifier())
        }
    }
    var isLoading = true
    var isRecent = true
    private var viewModel = TenantComplaintViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.showsVerticalScrollIndicator = false
        addressLbl.text = LocalizationKeys.currentAddress.rawValue.localizeString()
        self.historyTableView.rowHeight = UITableView.automaticDimension
        self.historyTableView.estimatedRowHeight = 44.0
        self.nameLabel.text = UserDefaults.standard.name
        self.addressValueLabel.text = UserDefaults.standard.currentHome
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
    }
    
    @objc private func loadComplaints(){
        self.animateSpinner()
        viewModel.getComplaints()
    }

    @IBAction func newBtnAction(_ sender: Any) {
        isRecent = true
        setupButton(complaintType: .new)
    }
    
    @IBAction func historyBtnAction(_ sender: Any) {
        isRecent = false
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
            showAlert(message: "First select property as home then you can add complaint.")
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
        if viewModel.isTaskCompleted(index: indexPath.row) == 1{
            Switcher.gotoTenantCompletedDetailScreen(delegate: self, complaintID: viewModel.getRecentID(index: indexPath.row))
        }
        else{
            Switcher.gotoTenantDetailScreen(delegate: self, complaintID: viewModel.getRecentID(index: indexPath.row))
        }
    }
}


