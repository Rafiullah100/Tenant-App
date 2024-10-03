//
//  SelectHomeViewController.swift
//  Raabt2
//
//  Created by Ngc on 22/07/2024.
//

import UIKit


class SelfPropertyDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.register(UINib(nibName: "SelfPropertyDetailTableViewCell", bundle: nil), forCellReuseIdentifier: SelfPropertyDetailTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var typeValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flatValueLabel: UILabel!
    @IBOutlet weak var companyNameValueLabel: UILabel!
    
    @IBOutlet weak var maintainedByLabel: UILabel!
    @IBOutlet weak var flatsLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    var propertyDetail: PropertiesRow?
    let viewModel = SelfDetailViewModel()
    private var isLoading = true
    var selectedHomeIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        type = .company
        
        typeLabel.text = LocalizationKeys.type.rawValue.localizeString()
        flatsLabel.text = LocalizationKeys.totalFlats.rawValue.localizeString()
        maintainedByLabel.text = LocalizationKeys.maintainedBy.rawValue.localizeString()
        
        updateUI()
        
        viewModel.flatList.bind { flatList in
            DispatchQueue.main.async {
                guard let _ = flatList else{return}
                self.stopAnimation()
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
        self.animateSpinner()
        viewModel.getList(propertyID: propertyDetail?.id ?? 0)
        
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
    
    private func updateUI(){
        let propertyType: PropertyType = propertyDetail?.buildingType == "building" ? .building : .villa
        nameLabel.text = "\(propertyDetail?.buildingType?.capitalized ?? "") \(propertyDetail?.buildingNo ?? ""), \(propertyDetail?.district ?? ""), \(propertyDetail?.city ?? "")"
        companyNameValueLabel.text = propertyDetail?.company?.name ?? "Not assigned to Company"
        flatValueLabel.text = "\(propertyDetail?.flats?.count ?? 0)"
        typeValueLabel.text = propertyType == .building ? "Building" : "Villa"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        
        if viewModel.getCount() == 0{
            self.tableView.setEmptyView("No Property to Show")
        }
        else{
            self.tableView.backgroundView = nil
        }
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelfPropertyDetailTableViewCell.cellReuseIdentifier(), for: indexPath) as! SelfPropertyDetailTableViewCell
        cell.homeTypeLbl.text = viewModel.getName(at: indexPath.row)
        cell.label.text = viewModel.isSelectedHome(at: indexPath.row)
        cell.selectAsYourHome = { [weak self] in
            if self?.viewModel.isCompanyAssigned(at: indexPath.row) == true{
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
