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
    private var isLoading = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false

        searchTextField.delegate = self
        searchView.clipsToBounds = true
        titlLabel.text = LocalizationKeys.selectPropertyAsYourHome.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchByTitle.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        type = .company
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        viewModel.propertyList.bind { [weak self] list in
            guard let _ = list else {return}
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.tableView.reloadData()
                self?.stopAnimation()
            }
        }
       callAPI()
        
        viewModel.selectHome.bind { select in
            guard let select = select else{return}
            self.stopAnimation()
            if select.success == true{
                NotificationCenter.default.post(name: Notification.Name(Constants.reloadOwnerProfile), object: nil)
                ToastManager.shared.showToast(message: LocalizationKeys.propertySelectedAsYourHome.rawValue.localizeString())
            }
            else{
                ToastManager.shared.showToast(message: select.message ?? "")
            }
        }
    }
    
    private func callAPI(){
        self.animateSpinner()
        viewModel.getProperties(search: searchTextField.text ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        
        if viewModel.getPropertiesCount() == 0{
            self.tableView.setEmptyView("No Property to Show")
        }
        else{
            self.tableView.backgroundView = nil
        }
        return viewModel.getPropertiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BothPropertyTableViewCell.cellReuseIdentifier(), for: indexPath) as! BothPropertyTableViewCell
        cell.property = viewModel.getProperty(at: indexPath.row)
        cell.buttonLabel.text = viewModel.isSelectedHome(at: indexPath.row) ? LocalizationKeys.yourHome.rawValue.localizeString() : LocalizationKeys.selectAsYourHome.rawValue.localizeString()
        cell.selectAsYourHome = { [weak self] in
            if self?.viewModel.isCompanyAssigned(at: indexPath.row) == true {
                self?.animateSpinner()
                self?.viewModel.selectAsYourHome(flatID: self?.viewModel.getFlatID(at: indexPath.row) ?? 0, tenantID: UserDefaults.standard.userID ?? 0)
                self?.selectedHomeIndex = indexPath.row
            }
            else{
                ToastManager.shared.showToast(message: LocalizationKeys.cantSelectAsYourhome.rawValue.localizeString())
            }
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

extension BothPropertyViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callAPI()
        return true
    }
}

