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
    
    var propertyDetail: PropertiesRow?
    let viewModel = SelfDetailViewModel()
    private var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        type = .company
        
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
                self.showAlert(message: "Flat selected as your home")
            }
            else{
                self.showAlert(message: select.message ?? "")
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
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelfPropertyDetailTableViewCell.cellReuseIdentifier(), for: indexPath) as! SelfPropertyDetailTableViewCell
        cell.homeTypeLbl.text = viewModel.getName(at: indexPath.row)
        cell.selectAsYourHome = { [weak self] in
            self?.animateSpinner()
            self?.viewModel.selectAsYourHome(flatID: self?.viewModel.getFlatID(at: indexPath.row) ?? 0, tenantID: UserDefaults.standard.userID ?? 0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
