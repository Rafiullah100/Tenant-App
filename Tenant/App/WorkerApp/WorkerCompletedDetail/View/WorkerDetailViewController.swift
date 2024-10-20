//
//  WorkerComplaintStatusViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/10/24.
//


import UIKit

class WorkerDetailViewController: BaseViewController {
    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var workerPhotoLabel: UILabel!
    @IBOutlet weak var completeView: UIView!
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
    
    @IBOutlet weak var uploadedCollectionView: UICollectionView!{
        didSet{
            uploadedCollectionView.register(ComplaintCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier())
            uploadedCollectionView.delegate = self
            uploadedCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var personValueLabel: UILabel!
    @IBOutlet weak var timeValueLabel: UILabel!
    @IBOutlet weak var scheduleValueLabel: UILabel!
    @IBOutlet weak var acceptedValueLabel: UILabel!
    @IBOutlet weak var postedValueLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var tenantValueLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
    @IBOutlet weak var ComplaintTitleLabel: UILabel!
    
    @IBOutlet weak var completedValueLabel: UILabel!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var viewMoreButtonView: UIView!
    @IBOutlet weak var descriptionValueLabel: UILabel!

    var complaintID: Int?
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
        type = .tenant
        
        viewModel.complaintDetail.bind { [unowned self] detail in
            guard let _ = detail else {return}
            self.stopAnimation()
            self.updateUI()
        }
        self.animateSpinner()
        viewModel.getComplaints(complaintID: complaintID ?? 0)
        
    }
    
    private func updateUI(){
        ComplaintTitleLabel.text = viewModel.getTitle()
//        propertyValueLabel.text = viewModel.getProperty()
        statusValueLabel.text = viewModel.getStatus()
        postedValueLabel.text = viewModel.getPostedDate()
        acceptedValueLabel.text = viewModel.getAcceptedDate()
        tenantValueLabel.text = viewModel.getTenantName()
        completedValueLabel.text = viewModel.isTaskCompleted() == 1 ? viewModel.getCompletedDate() : "Waiting for confirmation"
        descriptionValueLabel.text = viewModel.getDescription()
        scheduleValueLabel.text = viewModel.getScheduleDate()
        timeValueLabel.text = viewModel.getScheduleTime()
        personValueLabel.text = viewModel.getMaintenancePersonContact()
        propertyValueLabel.attributedText = viewModel.getAddress()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(propertyLabelTapped))
        propertyValueLabel.addGestureRecognizer(tapGesture)
        collectionView.reloadData()
        uploadedCollectionView.reloadData()
    }
    
    @objc func propertyLabelTapped() {
        guard let property = viewModel.getProperty() else { return }
        Switcher.gotoWorkerPropertyDetail(delegate: self, property: property)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func showMoreBtnAction(_ sender: Any) {
        if descriptionView.isHidden{
            moreButton.setTitle(LocalizationKeys.clickToHideDescription.rawValue.localizeString(), for: .normal)
        }
        else{
            moreButton.setTitle(LocalizationKeys.clickToViewDescription.rawValue.localizeString(), for: .normal)
        }
        descriptionView.isHidden = !descriptionView.isHidden
    }
}

extension WorkerDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == uploadedCollectionView{
            return viewModel.getCompanyPhotoCount()
        }
        else{
            return viewModel.getPhotosCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier(), for: indexPath)as! ComplaintCollectionViewCell
        if collectionView == uploadedCollectionView{
            cell.configure(with: viewModel.getCompanyPhoto(index: indexPath.row))
        }
        else{
            cell.configure(with: viewModel.getPhoto(index: indexPath.row))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoPhotoViewer(delegate: self, photos: collectionView == uploadedCollectionView ? viewModel.getAllWorkerPhoto() : viewModel.getAllPhoto(), position: indexPath)
    }
}

extension WorkerDetailViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
