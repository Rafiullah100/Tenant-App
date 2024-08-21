//
//  ContactPersonViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/11/24.
//

import UIKit
struct ContactPerson {
    let name: String?
    let contact: String?
    
    
}
class ContactPersonViewController: BaseViewController {

    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ContactPersonTableViewCell", bundle: nil), forCellReuseIdentifier: ContactPersonTableViewCell.cellReuseIdentifier())
        }
    }
    private var viewModel = ContactViewModel()

    let contacts = [ContactPerson(name: "Owner Contact", contact: "+233 2471 72 944"), ContactPerson(name: "Maintenance Company Contact", contact: "+233 5921 61 530")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactLabel.text = LocalizationKeys.contactPerson.rawValue.localizeString()
        backButton.setImage(UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en"), for: .normal)
        
        viewModel.contactList.bind { [unowned self] list in
            guard let _ = list else {return}
            self.stopAnimation()
            self.tableView.reloadData()
        }
        self.animateSpinner()
        viewModel.getComplaints(id: UserDefaults.standard.userID ?? 0)
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ContactPersonViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getContactCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactPersonTableViewCell.cellReuseIdentifier(), for: indexPath) as! ContactPersonTableViewCell
        cell.contact = viewModel.getContact(at: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
