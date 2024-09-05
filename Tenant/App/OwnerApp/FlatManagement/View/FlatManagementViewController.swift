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
    var buildingNumer: String?

    let viewModel = FlatViewModel()
    var propertyID: Int?
    private var isLoading = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        FlatTableView.showsVerticalScrollIndicator = false

        searchView.clipsToBounds = true
        titlLabel.text = buildingNumer ?? ""
        viewControllerTitle = LocalizationKeys.flatManagement.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchFlatNumber.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        
        type = .company
        
        viewModel.flatList.bind { flatList in
            DispatchQueue.main.async {
                guard let _ = flatList else{return}
                self.stopAnimation()
                self.isLoading = false
                self.FlatTableView.reloadData()
            }
        }
        networkingCall()
        NotificationCenter.default.addObserver(self, selector: #selector(networkingCall), name: Notification.Name(Constants.reloadFlats), object: nil)
    }
    
    @objc private func networkingCall()  {
        self.animateSpinner()
        viewModel.getList(propertyID: propertyID ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        Switcher.gotoAddFlat(delegate: self, propertyID: propertyID ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        if viewModel.getCount() == 0{
            self.FlatTableView.setEmptyView("No Flat Found!")
        }
        else{
            self.FlatTableView.backgroundView = nil
        }
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FlatTableView.dequeueReusableCell(withIdentifier: FlatCardTableViewCell.cellReuseIdentifier(), for: indexPath) as! FlatCardTableViewCell
        cell.flatNumberLbl.text = viewModel.getName(at: indexPath.row)
        cell.noTenantView.isHidden = viewModel.isAssignedToTenant(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isAssignedToTenant(at: indexPath.row) == true {
            guard let flat = viewModel.getFlat(at: indexPath.row) else { return }
            Switcher.gotoRemoveTenant(delegate: self, flatDetail: flat)
        }
        else{
            Switcher.gotoAddTenant(delegate: self, flatID: viewModel.getFlatID(at: indexPath.row), flatNumber: viewModel.getFlatNumber(at: indexPath.row))
        }
    }
}
