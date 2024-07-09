//
//  HomeViewController.swift
//  Raabt2
//
//  Created by Ngc on 04/07/2024.
//

import UIKit


class MaintenanceHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ongoingButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "MaintenaceTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            
            tableView.register(UINib(nibName: "OngoingMaintenanceTableViewCell", bundle: nil), forCellReuseIdentifier: "ongoing")
        }
    }
    
    var isNew = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        searchView.clipsToBounds = true
        newButton.setTitle(LocalizationKeys.new.rawValue.localizeString(), for: .normal)
        ongoingButton.setTitle(LocalizationKeys.ongoing.rawValue.localizeString(), for: .normal)
        searchTextField.placeholder = LocalizationKeys.search.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
    }
    
    @IBAction func ongoingBtnAction(_ sender: Any) {
        isNew = false
        setupButton()
    }
    
    @IBAction func newBtnAction(_ sender: Any) {
        isNew = true
        setupButton()
    }
    
    private func setupButton(){
        tableView.reloadData()
        if isNew {
            newButton.backgroundColor = CustomColor.appColor.color
            ongoingButton.backgroundColor = CustomColor.grayColor.color
        }
        else{
            ongoingButton.backgroundColor = CustomColor.appColor.color
            newButton.backgroundColor = CustomColor.grayColor.color
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNew {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MaintenaceTableViewCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ongoing", for: indexPath) as! OngoingMaintenanceTableViewCell
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isNew{
            return 100
        }
        else{
            return 115
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoMaintenanceDetail(delegate: self)
    }
}
