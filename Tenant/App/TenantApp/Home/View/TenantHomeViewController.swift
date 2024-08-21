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
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var historyButton: UIButton!
    var isLoading = true
    var isRecent = true
    private var viewModel = TenantComplaintViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.token ?? "")
        buildingLabel.text = "\(LocalizationKeys.buildingNo.rawValue.localizeString()):   12ADF"
        flatLabel.text = "\(LocalizationKeys.flatNo.rawValue.localizeString()):   14"
        historyLabel.text = LocalizationKeys.recent.rawValue.localizeString()
        historyTableView.showsVerticalScrollIndicator = false
        
        viewModel.complaintList.bind { [unowned self] list in
            guard let _ = list else {return}
            self.isLoading = false
            self.stopAnimation()
            self.historyTableView.reloadData()
        }
        self.historyTableView.rowHeight = UITableView.automaticDimension
        self.historyTableView.estimatedRowHeight = 44.0
        self.animateSpinner()
        viewModel.getComplaints()
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        Switcher.gotoAddComplaintScreen(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func historyBtnAction(_ sender: Any) {
        isRecent.toggle()
        self.historyTableView.reloadData()
        if isRecent {
            historyButton.setImage(UIImage(named: "recent"), for: .normal)
            historyLabel.text = LocalizationKeys.recent.rawValue.localizeString()
        }
        else{
            historyButton.setImage(UIImage(named: "refresh"), for: .normal)
            historyLabel.text = LocalizationKeys.history.rawValue.localizeString()
        }
    }
    
    @IBAction func contactButtonAction(_ sender: Any) {
        Switcher.gotoContactList(delegate: self)
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
        let cell = historyTableView.dequeueReusableCell(withIdentifier: TenantTableViewCell.cellReuseIdentifier(), for: indexPath) as! TenantTableViewCell
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


