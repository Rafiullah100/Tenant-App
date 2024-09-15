//
//  RemoveFlatViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/18/24.
//

import UIKit

class RemoveTenanatViewController: BaseViewController {

    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contactValueLabel: UILabel!
    var flatDetail: FlatRow?
    let viewModel = DeleteTenantViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.setTitle(LocalizationKeys.deleteTenant.rawValue.localizeString(), for: .normal)
        contactLabel.text = LocalizationKeys.contact.rawValue.localizeString()
        currentLabel.text = LocalizationKeys.currentTenant.rawValue.localizeString()

        type = .company
        updateUI()
        
        viewModel.delete.bind { delete in
            DispatchQueue.main.async {
                guard let delete = delete else{return}
                self.stopAnimation()
                if delete.success == true{
                    ToastManager.shared.showToast(message: delete.message ?? "")
                    NotificationCenter.default.post(name: Notification.Name(Constants.reloadFlats), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    ToastManager.shared.showToast(message: delete.message ?? "")
                }
            }
        }
    }
    
    private func updateUI(){
        viewControllerTitle = "\(LocalizationKeys.flat.rawValue.localizeString()) \(flatDetail?.flatNo ?? "")"
        nameLabel.text = flatDetail?.ownersTenants?.name
        contactValueLabel.text = flatDetail?.ownersTenants?.contact
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func deleteTenantBtn(_ sender: Any) {
        self.animateSpinner()
        viewModel.deleteTenant(flatID: flatDetail?.id ?? 0)
    }
    
}
