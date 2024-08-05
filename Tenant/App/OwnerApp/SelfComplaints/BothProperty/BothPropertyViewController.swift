//
//  FlatManagementViewController.swift
//  Raabt2
//
//  Created by Ngc on 13/07/2024.
//

import UIKit

class BothPropertyViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "BothPropertyTableViewCell", bundle: nil), forCellReuseIdentifier: BothPropertyTableViewCell.cellReuseIdentifier())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false

        searchView.clipsToBounds = true
        titlLabel.text = "Select a Property as Your Own Home"
        searchTextField.placeholder = LocalizationKeys.searchByTitle.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        type = .company
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BothPropertyTableViewCell.cellReuseIdentifier(), for: indexPath) as! BothPropertyTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoFlatasHomeVC(delegate: self)
    }
}
