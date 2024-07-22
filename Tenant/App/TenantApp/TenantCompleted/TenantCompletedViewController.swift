//
//  StatusDoneViewController.swift
//  Raabt
//
//  Created by Ngc on 01/07/2024.
//

import UIKit

class TenantCompletedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var complaintIdLabel: UILabel!
    @IBOutlet weak var collectionViewDone: UICollectionView!{
        didSet{
            collectionViewDone.register(StatusDoneCollectionViewCell.nib(), forCellWithReuseIdentifier: StatusDoneCollectionViewCell.identifier)
            collectionViewDone.delegate = self
            collectionViewDone.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setImage(UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en"), for: .normal)
        complaintIdLabel.text = LocalizationKeys.complaintID.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.photosUploaded.rawValue.localizeString()
        confirmButton.setTitle(LocalizationKeys.confirm.rawValue.localizeString(), for: .normal)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusDoneCollectionViewCell.identifier, for: indexPath)as! StatusDoneCollectionViewCell
            
            cell.configure(with: UIImage(named: "Img1")!)
          
            
            return cell
            
        }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TenantCompletedViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.83, height: 76.83)
    }
}
