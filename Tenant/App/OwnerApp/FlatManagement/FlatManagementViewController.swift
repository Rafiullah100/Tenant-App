//
//  FlatManagementViewController.swift
//  Raabt2
//
//  Created by Ngc on 13/07/2024.
//

import UIKit

class FlatManagementViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    //
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var FlatTableView: UITableView!{
        didSet{
            FlatTableView.delegate = self
            FlatTableView.dataSource = self
            FlatTableView.register(UINib(nibName: "FlatCardTableViewCell", bundle: nil), forCellReuseIdentifier: FlatCardTableViewCell.cellReuseIdentifier())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FlatTableView.showsVerticalScrollIndicator = false

        searchView.clipsToBounds = true
        titlLabel.text = LocalizationKeys.flatManagement.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchFlatNumber.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        type = .company
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        Switcher.gotoAddFlat(delegate: self)
    }
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FlatTableView.dequeueReusableCell(withIdentifier: FlatCardTableViewCell.cellReuseIdentifier(), for: indexPath) as! FlatCardTableViewCell
        if indexPath.row % 2 == 0{
            cell.noTenantView.isHidden = true
        }
        else{
            cell.noTenantView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0{
            Switcher.gotoRemoveTenant(delegate: self)
        }
        else{
            Switcher.gotoAddTenant(delegate: self)
        }
    }
}
