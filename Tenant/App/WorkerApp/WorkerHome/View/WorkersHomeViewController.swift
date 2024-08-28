//
//  WorkersViewController.swift
//  Worker
//
//  Created by Ngc on 10/07/2024.
//

import UIKit

struct workDetails{
    let title:String?
    let by:String?
    let maintanance:String?
    let status:String?
    let postedDate:String?
    let assignedDate:String?
}


class WorkersHomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var workerHomeTableView: UITableView!{
        didSet{
            workerHomeTableView.delegate = self
            workerHomeTableView.dataSource = self
            workerHomeTableView.register(UINib(nibName: "WorkerTableViewCell", bundle: nil), forCellReuseIdentifier: WorkerTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    private var viewModel = WorkersComplaintViewModel()
    var isLoading = true
    private var complaintType: WorkerComplaintType = .new

    override func viewDidLoad() {
        super.viewDidLoad()
        workerHomeTableView.showsVerticalScrollIndicator = false
        newButton.setTitle(LocalizationKeys.new.rawValue.localizeString(), for: .normal)
        completedButton.setTitle(LocalizationKeys.completed.rawValue.localizeString(), for: .normal)
        
        nameLabel.text = UserDefaults.standard.name
        mobileLabel.text = UserDefaults.standard.mobile
        
        viewModel.complaintList.bind { [unowned self] list in
            guard let _ = list else {return}
            self.isLoading = false
            self.stopAnimation()
            self.workerHomeTableView.reloadData()
        }
        self.workerHomeTableView.rowHeight = UITableView.automaticDimension
        self.workerHomeTableView.estimatedRowHeight = 44.0
        self.animateSpinner()
        viewModel.getComplaints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        complaintType = .new
        setupButton(complaintType: .new)
    }
    @IBAction func completeBtnAction(_ sender: Any) {
        complaintType = .completed
        setupButton(complaintType: .completed)
    }
    
    private func setupButton(complaintType: WorkerComplaintType = .new){
        newButton.backgroundColor = CustomColor.grayColor.color
        completedButton.backgroundColor = CustomColor.grayColor.color
        switch complaintType {
        case .new:
            newButton.backgroundColor = CustomColor.appColor.color
        case .completed:
            completedButton.backgroundColor = CustomColor.appColor.color
        }
        workerHomeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        switch complaintType {
        case .new:
            if viewModel.getRecentCount() == 0{
                self.workerHomeTableView.setEmptyView()
            }
            else{
                self.workerHomeTableView.backgroundView = nil
            }
            return viewModel.getRecentCount()

        case .completed:
            if viewModel.getCompletedCount() == 0{
                self.workerHomeTableView.setEmptyView()
            }
            else{
                self.workerHomeTableView.backgroundView = nil
            }
            return viewModel.getCompletedCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkerTableViewCell.cellReuseIdentifier(), for: indexPath) as! WorkerTableViewCell
        if complaintType == .new{
            cell.complaint = viewModel.getRecentComplaint(index: indexPath.row)
        }
        else{
            cell.complaint = viewModel.getCompletedComplaint(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if complaintType == .new{
            Switcher.gotoWorkerOngoingDetailScreen(delegate: self, complaintID: viewModel.getRecentComplaintID(at: indexPath.row))
        }
        else {
            Switcher.gotoWorkerComplaintDetailScreen(delegate: self, complaintID: viewModel.getCompletedComplaintID(at: indexPath.row))
        }
    }
}
