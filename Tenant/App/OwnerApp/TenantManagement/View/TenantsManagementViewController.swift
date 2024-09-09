//
//  TenantsManagementViewController.swift
//  Raabt2
//
//  Created by Ngc on 13/07/2024.
//

import UIKit

class TenantsManagementViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var cardCollectionView: UICollectionView!{
        didSet{
            cardCollectionView.register(TenantCollectionViewCell.nib(), forCellWithReuseIdentifier: TenantCollectionViewCell.cellReuseIdentifier())
            cardCollectionView.delegate = self
            cardCollectionView.dataSource = self
        }
    }
    
    var buildingNumer: String?

    let viewModel = PropertyTenantsViewModel()
    var propertyID: Int?
    private var isLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollectionView.showsVerticalScrollIndicator = false

        searchTextField.delegate = self
        viewControllerTitle = LocalizationKeys.tenantManagement.rawValue.localizeString()
        searchTextField.placeholder = LocalizationKeys.searchTenants.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        type = .company
        
        titlLabel.text = buildingNumer ?? ""
        
        viewModel.tenantList.bind { tenantList in
            DispatchQueue.main.async {
                guard let _ = tenantList else{return}
                self.stopAnimation()
                self.isLoading = false
                self.cardCollectionView.reloadData()
            }
        }
        
        viewModel.delete.bind { delete in
            guard let delete = delete else{return}
            if delete.success == true{
                DispatchQueue.main.async {
                    self.stopAnimation()
                    self.showAlert(message: delete.message ?? "")
                    self.networkingCall()
                }
            }
            else{
                self.showAlert(message: delete.message ?? "")
            }
        }
        
        networkingCall()
    }
    
    @objc private func networkingCall()  {
        self.animateSpinner()
        viewModel.getList(propertyID: propertyID ?? 0, search: searchTextField.text ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchView.layer.masksToBounds = true
        searchView.clipsToBounds = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoading{
            return 0
        }
        if viewModel.getCount() == 0{
            self.cardCollectionView.setEmptyView("No Tenants Found!")
        }
        else{
            self.cardCollectionView.backgroundView = nil
        }
        return viewModel.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: TenantCollectionViewCell.cellReuseIdentifier(), for: indexPath)as! TenantCollectionViewCell
        cell.tenants = viewModel.getTenant(at: indexPath.row)
        cell.delete = {
            self.animateSpinner()
            self.viewModel.deleteTenant(flatID: self.viewModel.getFlatID(at: indexPath.row))
        }
        return cell
    }
}

extension TenantsManagementViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 10
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: 150)
    }
}




extension TenantsManagementViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        networkingCall()
        return true
    }
}
