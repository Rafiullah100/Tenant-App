//
//  PhotoViewerViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 9/16/24.
//

import UIKit

class PhotoViewerViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var photos: [ComplainImage]?
    var addComplaintPhoto: [UIImage]?
    var position: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .company
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            guard let position = self.position else { return }
            self.collectionView.scrollToItem(at: position, at: [.left], animated: false)
        }
    }
}

extension PhotoViewerViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if addComplaintPhoto != nil{
            return addComplaintPhoto?.count ?? 0
        }
        else{
            return photos?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! PhotoViewerCollectionViewCell
        if addComplaintPhoto != nil{
            cell.viewAddComplaintPhoto(photo: addComplaintPhoto?[indexPath.row])
        }
        else{
            cell.configure(with: photos?[indexPath.row].imageURL)
        }
        return cell
    }
}

extension PhotoViewerViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}


