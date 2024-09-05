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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollectionView.showsVerticalScrollIndicator = false

        viewControllerTitle = LocalizationKeys.tenantManagement.rawValue.localizeString()
        titlLabel.text = "building #"
        searchTextField.placeholder = LocalizationKeys.searchTenants.rawValue.localizeString()
        searchTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        type = .company
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
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: TenantCollectionViewCell.cellReuseIdentifier(), for: indexPath)as! TenantCollectionViewCell
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



