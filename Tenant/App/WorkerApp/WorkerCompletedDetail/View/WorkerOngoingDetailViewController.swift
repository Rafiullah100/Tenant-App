//
//  WorkerOngoingDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/31/24.
//

import UIKit


class WorkerOngoingDetailViewController: BaseViewController  {
    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var workerPhotoLabel: UILabel!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var noOfFileLabel: UILabel!
    @IBOutlet weak var personValueLabel: UILabel!
    @IBOutlet weak var timeValueLabel: UILabel!
    @IBOutlet weak var scheduleValueLabel: UILabel!
    @IBOutlet weak var acceptedValueLabel: UILabel!
    @IBOutlet weak var postedValueLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var tenantValueLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
    @IBOutlet weak var ComplaintTitleLabel: UILabel!
    @IBOutlet weak var photosView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var acceptedLabel: UILabel!
    @IBOutlet weak var postedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ComplaintCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier())
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var uploadedCollectionView: UICollectionView!{
        didSet{
            uploadedCollectionView.register(ComplaintCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier())
            uploadedCollectionView.delegate = self
            uploadedCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var viewMoreButtonView: UIView!
    
    @IBOutlet weak var descriptionValueLabel: UILabel!
    
    var complaintID: Int?
    var selectedImages = [UIImage]()
    private var viewModel = WorkerDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = false
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        postedLabel.text = LocalizationKeys.postedOn.rawValue.localizeString()
        descriptionLabel.text = LocalizationKeys.complaintDescription.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.complaintPhoto.rawValue.localizeString()
        propertyLabel.text = LocalizationKeys.property.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        scheduleLabel.text = LocalizationKeys.schedule.rawValue.localizeString()
        dateLabel.text = LocalizationKeys.dateAndTime.rawValue.localizeString()
        personLabel.text = LocalizationKeys.person.rawValue.localizeString()
        acceptedLabel.text = LocalizationKeys.acceptedOn.rawValue.localizeString()
        workerPhotoLabel.text = LocalizationKeys.workerCompletionPicture.rawValue.localizeString()
        propertyValueLabel.text = viewModel.getProperty()

        type = .tenant
        hideGalleryView()
        
        viewModel.complaintDetail.bind { [unowned self] detail in
            guard let _ = detail else {return}
            self.stopAnimation()
            self.updateUI()
            self.collectionView.reloadData()
        }
        self.animateSpinner()
        viewModel.getComplaints(complaintID: complaintID ?? 0)
        
        viewModel.completion.bind { [unowned self] complete in
            guard let complete = complete else {return}
            self.stopAnimation()
            if complete.success == true{
                showAlertWithbuttton(message: complete.message ?? "") {
                    NotificationCenter.default.post(name: NSNotification.Name(Constants.reloadWorkerComplaints), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                showAlert(message: complete.message ?? "")
            }
        }
    }
    
    private func updateUI(){
        ComplaintTitleLabel.text = viewModel.getTitle()
        propertyValueLabel.text = viewModel.getProperty()
        statusValueLabel.text = viewModel.getStatus()
        postedValueLabel.text = viewModel.getPostedDate()
        acceptedValueLabel.text = viewModel.getAcceptedDate()
        tenantValueLabel.text = viewModel.getTenantName()
        descriptionValueLabel.text = viewModel.getDescription()
        scheduleValueLabel.text = viewModel.getScheduleDate()
        timeValueLabel.text = viewModel.getScheduleTime()
        personValueLabel.text = viewModel.getMaintenancePersonContact()
//        completedView.isHidden = viewModel.hideCompletedView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
        
    private func hideGalleryView(){
        self.photosView.isHidden = selectedImages.count == 0 ? true : false
    }
    
    @IBAction func pickImages(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func markCompleteBtnAction(_ sender: Any) {
        if self.selectedImages.count > 0{
            self.animateSpinner()
            viewModel.markComplete(images: selectedImages, complaintID: complaintID ?? 0)
        }
        else {
            showAlert(message: "please add pcitures of your work and then try agian")
        }
    }
    
    @IBAction func showMoreBtnAction(_ sender: Any) {
        if descriptionView.isHidden{
            moreButton.setTitle("Click to hide description", for: .normal)
        }
        else{
            moreButton.setTitle("Click to view description", for: .normal)
        }
        descriptionView.isHidden = !descriptionView.isHidden
    }
}

extension WorkerOngoingDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == uploadedCollectionView {
            return selectedImages.count 
        }
        else{
            return viewModel.getPhotosCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == uploadedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplaintCollectionViewCell.identifier, for: indexPath)as! ComplaintCollectionViewCell
            cell.imageView.image = selectedImages[indexPath.row]
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplaintCollectionViewCell.identifier, for: indexPath)as! ComplaintCollectionViewCell
            cell.configure(with: viewModel.getPhoto(index: indexPath.row))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  collectionView == uploadedCollectionView{
            Switcher.gotoPhotoViewer(delegate: self, addComplaintPhoto: selectedImages, position: indexPath)
        }
        else{
            Switcher.gotoPhotoViewer(delegate: self, photos: viewModel.getAllPhoto(), position: indexPath)
        }
    }
}

extension WorkerOngoingDetailViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
                self.selectedImages.append(image)
                print(self.selectedImages.count)
            self.noOfFileLabel.text = "\(self.selectedImages.count) Files selected"
                self.uploadedCollectionView.reloadData()
        }
        hideGalleryView()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension WorkerOngoingDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
