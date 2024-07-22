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


class WorkersHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        
        newButton.setTitle(LocalizationKeys.new.rawValue.localizeString(), for: .normal)
        completedButton.setTitle(LocalizationKeys.completed.rawValue.localizeString(), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkerTableViewCell.cellReuseIdentifier(), for: indexPath) as! WorkerTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoWorkerDetailScreen(delegate: self)
    }
}
