//
//  NewComplaintFormViewController.swift
//  Raabt
//
//  Created by Ngc on 28/06/2024.
//

import UIKit

class AddTenantViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var galleryView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var noFileLabel: UILabel!
    @IBOutlet weak var fileButton: UIButton!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var enterTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ComplaintCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplaintCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    var selectedImages = [UIImage]()
    var pickerView = UIPickerView()
    private var viewModel = AddTenantViewModel()
    var skillID: Int?
    
    var addType: AddComplaintType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideGalleryView()
        titleTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        descriptionTextView.textAlignment = Helper.shared.isRTL() ? .right : .left
        enterTitleLabel.text = LocalizationKeys.title.rawValue.localizeString()
        categoryLabel.text = LocalizationKeys.branch.rawValue.localizeString()
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        sizeLabel.text = LocalizationKeys.imageSize.rawValue.localizeString()
        noFileLabel.text = LocalizationKeys.noFileChoose.rawValue.localizeString()
        fileButton.setTitle(LocalizationKeys.chooseFile.rawValue.localizeString(), for: .normal)
        submitButton.setTitle(LocalizationKeys.submitComplaint.rawValue.localizeString(), for: .normal)
        categoryTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        categoryTextField.placeholder = LocalizationKeys.selectBranch.rawValue.localizeString()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        
        type = .tenant
        viewControllerTitle = LocalizationKeys.newComplaint.rawValue.localizeString()
        
        collectionView.showsVerticalScrollIndicator = false
        
        viewModel.skill.bind { skill in
            guard let _ = skill else {return}
            self.pickerView.reloadAllComponents()
        }
        
        viewModel.add.bind { add in
            guard let add = add else {return}
            self.stopAnimation()
            if add.success == true{
                self.showAlertWithbutttons(message: add.message ?? "") {
                    if self.addType == .tenant{
                        NotificationCenter.default.post(name: NSNotification.Name(Constants.reloadTenantComplaints), object: nil)
                    }
                    else{
                        NotificationCenter.default.post(name: NSNotification.Name(Constants.reloadSelfComplaints), object: nil)
                    }
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showAlert(message: add.message ?? "")
            }
        }
        viewModel.getSkillcategories()
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        let add = AddComplaintInputModel(title: titleTextField.text ?? "", description: descriptionTextView.text ?? "", images: selectedImages.count,  skill: skillID ?? 0, propertyIdIfTenant: UserDefaults.standard.propertyIDIfTenant ?? 0, flatIdIfTenant: UserDefaults.standard.flatIDIfTenant ?? 0)
        let validationResponse = viewModel.isFormValid(complaint: add)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.addComplaint(image: selectedImages)
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func hideGalleryView(){
        self.galleryView.isHidden = selectedImages.count == 0 ? true : false
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

extension AddTenantViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getSkillCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getSkillName(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        skillID = viewModel.getSkillID(at: row)
        categoryTextField.text = viewModel.getSkillName(at: row)
    }
}
