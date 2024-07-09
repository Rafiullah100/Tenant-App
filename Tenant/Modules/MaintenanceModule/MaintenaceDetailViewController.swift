//
//  MaintenaceDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/8/24.
//

import UIKit

class MaintenaceDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ComplainDetailCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplainDetailCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var complaintIdLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var postLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.setImage(UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en"), for: .normal)
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        complaintIdLabel.text = LocalizationKeys.complaintID.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.photos.rawValue.localizeString()
        postLabel.text = LocalizationKeys.posted.rawValue.localizeString()
        
        doneButton.setTitle(LocalizationKeys.done.rawValue.localizeString(), for: .normal)
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

extension MaintenaceDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.83, height: 76.83)
    }
}

