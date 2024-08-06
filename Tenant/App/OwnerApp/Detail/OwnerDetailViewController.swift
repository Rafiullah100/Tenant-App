//
//  OwnerDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/20/24.
//

import UIKit

class OwnerDetailViewController: BaseViewController {
    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var companyPhotoView: UIView!
    @IBOutlet weak var tenantPhotoView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var acceptedLabel: UILabel!
    @IBOutlet weak var postedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var companyCollectionView: UICollectionView!{
        didSet{
            companyCollectionView.register(ComplaintCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier())
            companyCollectionView.delegate = self
            companyCollectionView.dataSource = self
        }
    }
    var ownerComplaint: OwnerComplaintType = .new
    
    
    @IBOutlet weak var tenantCollectionView: UICollectionView!{
        didSet{
            tenantCollectionView.register(ComplaintCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier())
            tenantCollectionView.delegate = self
            tenantCollectionView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        companyCollectionView.showsVerticalScrollIndicator = false
        tenantCollectionView.showsVerticalScrollIndicator = false

        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        postedLabel.text = LocalizationKeys.postedOn.rawValue.localizeString()
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.complaintPhoto.rawValue.localizeString()
        propertyLabel.text = LocalizationKeys.property.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        scheduleLabel.text = LocalizationKeys.schedule.rawValue.localizeString()
        dateLabel.text = LocalizationKeys.dateAndTime.rawValue.localizeString()
        personLabel.text = LocalizationKeys.person.rawValue.localizeString()
        acceptedLabel.text = LocalizationKeys.acceptedOn.rawValue.localizeString()
        
        if ownerComplaint == .new {
            companyPhotoView.isHidden = true
        }
        else if ownerComplaint == .rejected{
            companyPhotoView.isHidden = true
            buttonsView.isHidden = true
        }
        else if ownerComplaint == .ongoing{
            companyPhotoView.isHidden = true
            buttonsView.isHidden = true
        }
        else if ownerComplaint == .completed{
            buttonsView.isHidden = true
        }
        
        type = .tenant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

}

extension OwnerDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier(), for: indexPath)as! ComplaintCollectionViewCell
        cell.configure(with: UIImage(named: "Img1")!)
        return cell
    }
}


extension OwnerDetailViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.83, height: 76.83)
    }
}
