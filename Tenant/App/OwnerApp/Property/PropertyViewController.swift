//
//  PropertyViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/12/24.
//

import UIKit

class PropertyViewController: BaseViewController {

    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "PropertyTableViewCell", bundle: nil), forCellReuseIdentifier: PropertyTableViewCell.cellReuseIdentifier())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false

        searchView.clipsToBounds = true
        flatLabel.text = LocalizationKeys.flats.rawValue.localizeString() + "   25"
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        propertyLabel.text = LocalizationKeys.properties.rawValue.localizeString() + "   Building"
        titlLabel.text = LocalizationKeys.myProperties.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchByTitle.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

    }
    @IBAction func addBtnAction(_ sender: Any) {
    }
}

extension PropertyViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyTableViewCell.cellReuseIdentifier(), for: indexPath) as! PropertyTableViewCell
        if indexPath.row % 2 == 0{
            cell.label.text = "Building 50, District ABC, City XYZ"
        }
        else{
            cell.label.text = "Villa 50, District ABC, City XYZ"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type: PropertyType = indexPath.row % 2 == 0 ? .building : .villa
        Switcher.gotoPropertyDetail(delegate: self, propertyType: type)
    }
}
