//
//  PropertyViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/12/24.
//

import UIKit

class PropertyViewController: UIViewController {

    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
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
        self.navigationController?.isNavigationBarHidden = true

        searchView.clipsToBounds = true
        flatLabel.text = LocalizationKeys.flats.rawValue.localizeString() + "   25"
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        propertyLabel.text = LocalizationKeys.properties.rawValue.localizeString() + "   Building"
        titleLabel.text = LocalizationKeys.myProperties.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchByTitle.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
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
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoPropertyDetail(delegate: self)
    }
}
