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

    override func viewDidLoad() {
        super.viewDidLoad()
        workerHomeTableView.showsVerticalScrollIndicator = false

        newButton.setTitle(LocalizationKeys.new.rawValue.localizeString(), for: .normal)
        completedButton.setTitle(LocalizationKeys.completed.rawValue.localizeString(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        setupButton(complaintType: .new)
    }
    @IBAction func completeBtnAction(_ sender: Any) {
        setupButton(complaintType: .completed)
    }
    
    private func setupButton(complaintType: WorkerComplaintType = .new){
        workerHomeTableView.reloadData()
        newButton.backgroundColor = CustomColor.grayColor.color
        completedButton.backgroundColor = CustomColor.grayColor.color
        switch complaintType {
        case .new:
            newButton.backgroundColor = CustomColor.appColor.color
        case .completed:
            completedButton.backgroundColor = CustomColor.appColor.color
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkerTableViewCell.cellReuseIdentifier(), for: indexPath) as! WorkerTableViewCell
        cell.colorView.backgroundColor = CustomColor.blueColor.color
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoWorkerOngoingDetailScreen(delegate: self)
    }
}
