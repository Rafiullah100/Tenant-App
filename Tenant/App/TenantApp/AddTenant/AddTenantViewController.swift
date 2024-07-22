//
//  NewComplaintFormViewController.swift
//  Raabt
//
//  Created by Ngc on 28/06/2024.
//

import UIKit

class AddTenantViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var galleryView: UIView!
    @IBOutlet weak var descriptionTextView: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var noFileLabel: UILabel!
    @IBOutlet weak var fileButton: UIButton!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var complaintLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ComplaintCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplaintCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    var selectedImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideGalleryView()
        backButton.setImage(UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en"), for: .normal)

        titleTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        descriptionTextView.textAlignment = Helper.shared.isRTL() ? .right : .left
        complaintLabel.text = LocalizationKeys.newComplaint.rawValue.localizeString()
        titleLabel.text = LocalizationKeys.title.rawValue.localizeString()
        categoryLabel.text = LocalizationKeys.category.rawValue.localizeString()
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        sizeLabel.text = LocalizationKeys.imageSize.rawValue.localizeString()
        noFileLabel.text = LocalizationKeys.noFileChoose.rawValue.localizeString()
        
        fileButton.setTitle(LocalizationKeys.chooseFile.rawValue.localizeString(), for: .normal)
        submitButton.setTitle(LocalizationKeys.submitComplaint.rawValue.localizeString(), for: .normal)
    }
    
    private func hideGalleryView(){
        self.galleryView.isHidden = selectedImages.count == 0 ? true : false
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pickImages(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplaintCollectionViewCell.identifier, for: indexPath)as! ComplaintCollectionViewCell
        cell.imageView.image = selectedImages[indexPath.row]
        return cell
    }
}

extension AddTenantViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

extension AddTenantViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImages.append(image)
            collectionView.reloadData()
        }
        hideGalleryView()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


