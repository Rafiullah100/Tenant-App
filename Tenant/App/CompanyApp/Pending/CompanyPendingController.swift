//
//  MaintenaceDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/8/24.
//

import UIKit

class CompanyPendingController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ComplainDetailCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplainDetailCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var complaintIdLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var assignButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        complaintIdLabel.text = LocalizationKeys.complaintID.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.photos.rawValue.localizeString()
        postLabel.text = LocalizationKeys.posted.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        collectionView.showsVerticalScrollIndicator = false

        assignButton.setTitle(LocalizationKeys.assignToWorker.rawValue.localizeString(), for: .normal)
        rejectButton.setTitle(LocalizationKeys.reject.rawValue.localizeString(), for: .normal)
        
        type = .tenant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplainDetailCollectionViewCell.identifier, for: indexPath)as! ComplainDetailCollectionViewCell
            cell.configure(with: UIImage(named: "Img1")!)
            return cell
            
        }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CompanyPendingController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.83, height: 76.83)
    }
}

