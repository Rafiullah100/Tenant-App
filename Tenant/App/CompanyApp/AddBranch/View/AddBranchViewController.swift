//
//  AddBranchViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/6/24.
//

import UIKit

class AddBranchViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CompanyProfileTableViewCell", bundle: nil), forCellReuseIdentifier: CompanyProfileTableViewCell.cellReuseIdentifier())
        }
    }  
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    var branchesList = [CompanyBranch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        branchLabel.text = LocalizationKeys.branches.rawValue.localizeString()
        print(branchesList)
        viewModel.added.bind { [unowned self] branch in
            guard let branch = branch else {return}
            self.stopAnimation()
            if branch.success == true{
                branchesList.append(CompanyBranch(id: 0, companyID: 0, name: nameTextField.text, contact: contactTextField.text, locationCode: "", district: "", city: "", timestamp: ""))
                self.nameTextField.text = ""
                self.contactTextField.text = ""
                self.addressTextField.text = ""
                self.tableView.reloadData()
            }
            else{
                showAlert(message: branch.message ?? "")
            }
        }
    }
    
    private var viewModel = AddBranchViewModel()
    var companyID: Int?
    
    @IBAction func addBtnAction(_ sender: Any) {
        let branch = AddBranchInputModel(companyID: UserDefaults.standard.userID ?? 0, name: nameTextField.text ?? "", address: addressTextField.text ?? "", mobile: contactTextField.text ?? "")
        let validationResponse = viewModel.isFormValid(branch: branch)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.addBranch()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
}

extension AddBranchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyProfileTableViewCell.cellReuseIdentifier(), for: indexPath) as! CompanyProfileTableViewCell
        cell.branch = branchesList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
