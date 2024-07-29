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
    var isNew = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newButton.setTitle(LocalizationKeys.new.rawValue.localizeString(), for: .normal)
        completedButton.setTitle(LocalizationKeys.completed.rawValue.localizeString(), for: .normal)
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        isNew = true
        setupButton()
    }
    @IBAction func completeBtnAction(_ sender: Any) {
        isNew = false
        setupButton()
    }
    
    private func setupButton(){
        workerHomeTableView.reloadData()
        if isNew {
            newButton.backgroundColor = CustomColor.appColor.color
            completedButton.backgroundColor = CustomColor.grayColor.color
        }
        else{
            completedButton.backgroundColor = CustomColor.appColor.color
            newButton.backgroundColor = CustomColor.grayColor.color
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkerTableViewCell.cellReuseIdentifier(), for: indexPath) as! WorkerTableViewCell
        if isNew{
            cell.colorView.backgroundColor = CustomColor.blueColor.color
        }
        else{
            cell.colorView.backgroundColor = CustomColor.greenColor.color
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoWorkerDetailScreen(delegate: self)
    }
}
