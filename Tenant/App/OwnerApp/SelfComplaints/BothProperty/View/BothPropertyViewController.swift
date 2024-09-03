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
    private var viewModel = SelfPropertyViewModel()
    var propertyType: PropertyType?

    var selectedHomeIndex: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false

        searchView.clipsToBounds = true
        titlLabel.text = "Select a Property as Your Own Home"
        searchTextField.placeholder = LocalizationKeys.searchByTitle.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        type = .company
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        viewModel.propertyList.bind { [weak self] list in
            guard let _ = list else {return}
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.stopAnimation()
            }
        }
        self.animateSpinner()
        viewModel.getProperties()
        
        viewModel.selectHome.bind { select in
            guard let select = select else{return}
            self.stopAnimation()
            if select.success == true{
                UserDefaults.standard.propertyIDIfTenant = self.viewModel.getPropertyID(at: self.selectedHomeIndex ?? 0)
                UserDefaults.standard.flatIDIfTenant = self.viewModel.getFlatID(at: self.selectedHomeIndex ?? 0)
                self.showAlert(message: "Property selected as your home")
            }
            else{
                self.showAlert(message: select.message ?? "")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPropertiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BothPropertyTableViewCell.cellReuseIdentifier(), for: indexPath) as! BothPropertyTableViewCell
        cell.property = viewModel.getProperty(at: indexPath.row)
        cell.buttonLabel.text = viewModel.isSelectedHome(at: indexPath.row) ? "Your Home" : "Select as your Home"
        cell.selectAsYourHome = { [weak self] in
            self?.animateSpinner()
            self?.viewModel.selectAsYourHome(flatID: self?.viewModel.getFlatID(at: indexPath.row) ?? 0, tenantID: UserDefaults.standard.userID ?? 0)
            self?.selectedHomeIndex = indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.getBuildingType(at: indexPath.row) == .building else {
            return
        }
        guard let detail = viewModel.getProperty(at: indexPath.row) else { return }
        Switcher.gotoSelfPropertyDetail(delegate: self, propertyDetail: detail)
    }
}
