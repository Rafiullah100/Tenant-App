//
//  WorkersViewController.swift
//  Worker
//
//  Created by Ngc on 10/07/2024.
//

import UIKit
import SDWebImage

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
    @IBOutlet weak var imageView: UIImageView!
    private var viewModel = WorkersComplaintViewModel()
    var isLoading = true
    private var complaintType: WorkerComplaintType = .new

    override func viewDidLoad() {
        super.viewDidLoad()
        workerHomeTableView.showsVerticalScrollIndicator = false
        newButton.setTitle(LocalizationKeys.current.rawValue.localizeString(), for: .normal)
        completedButton.setTitle(LocalizationKeys.completed.rawValue.localizeString(), for: .normal)
        
        viewModel.complaintList.bind { [unowned self] list in
            guard let _ = list else {return}
            self.isLoading = false
            self.stopAnimation()
            self.workerHomeTableView.reloadData()
            ApiService.shared.registerDeviceTokenForNotificaiton()
        }
        self.workerHomeTableView.rowHeight = UITableView.automaticDimension
        self.workerHomeTableView.estimatedRowHeight = 44.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(Constants.reloadWorkerComplaints), object: nil)

        loadData()
    }
    
    @objc func loadData(){
        self.animateSpinner()
        viewModel.getComplaints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        nameLabel.text = UserDefaults.standard.name
        mobileLabel.text = UserDefaults.standard.mobile
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")), placeholderImage: UIImage(named: "User"))
        print(UserDefaults.standard.profileImage ?? "")
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        complaintType = .new
        setupButton(complaintType: .new)
    }
    @IBAction func completeBtnAction(_ sender: Any) {
        complaintType = .completed
        setupButton(complaintType: .completed)
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        Switcher.gotoMenu(delegate: self, menuType: .worker)
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
        var comlaintId = 0
        var istaskCompletedFromWorkerSide = false
        if complaintType == .new{
            comlaintId = viewModel.getRecentComplaintID(at: indexPath.row)
            istaskCompletedFromWorkerSide = viewModel.isRecentTaskCompleted(at: indexPath.row)
        }
        else{
            comlaintId = viewModel.getCompletedComplaintID(at: indexPath.row)
            istaskCompletedFromWorkerSide = viewModel.isHistoryTaskCompleted(at: indexPath.row)
        }
        
        if istaskCompletedFromWorkerSide {
            Switcher.gotoWorkerComplaintDetailScreen(delegate: self, complaintID: comlaintId)
        }
        else{
            Switcher.gotoWorkerOngoingDetailScreen(delegate: self, complaintID: comlaintId)
        }
    }
}
