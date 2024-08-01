//
//  FlatManagementViewController.swift
//  Raabt2
//
//  Created by Ngc on 13/07/2024.
//

import UIKit

class FlatManagementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
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
        searchView.clipsToBounds = true
        backButton.setImage(UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en"), for: .normal)
        titleLabel.text = LocalizationKeys.flatManagement.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchFlatNumber.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        return 55
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
