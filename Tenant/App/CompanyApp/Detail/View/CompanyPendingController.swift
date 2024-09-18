//
//  MaintenaceDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/8/24.
//

import UIKit

class CompanyPendingController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    
    @IBOutlet weak var descriptionTextView: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var tenantValueLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
    @IBOutlet weak var complaintTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ComplainDetailCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplainDetailCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var workerCollectionView: UICollectionView!{
        didSet{
            workerCollectionView.register(ComplainDetailCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplainDetailCollectionViewCell.identifier)
            workerCollectionView.delegate = self
            workerCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var acceptedView: UIView!
    @IBOutlet weak var complaintIdLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var assignButton: UIButton!
    @IBOutlet weak var postedValueLabel: UILabel!
    @IBOutlet weak var acceptedValueLabel: UILabel!
    @IBOutlet weak var acceptedLabel: UILabel!
    @IBOutlet weak var postedLabel: UILabel!
    @IBOutlet weak var scheduleView: UIView!
    
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var personValueLabel: UILabel!
    @IBOutlet weak var scheduleValueLabel: UILabel!
    @IBOutlet weak var dateValueLabel: UILabel!
    @IBOutlet weak var workerPhotoView: UIView!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var viewMoreButtonView: UIView!
    
    var complaintID: Int?
    private var viewModel = CompanyDetailViewModel()
    private var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        complaintIdLabel.text = LocalizationKeys.property.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.photos.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        postedLabel.text = LocalizationKeys.postedOn.rawValue.localizeString()
        acceptedLabel.text = LocalizationKeys.acceptedOn.rawValue.localizeString()
        scheduleLabel.text = LocalizationKeys.schedule.rawValue.localizeString()
        dateLabel.text = LocalizationKeys.dateAndTime.rawValue.localizeString()
        personLabel.text = LocalizationKeys.person.rawValue.localizeString()
        collectionView.showsVerticalScrollIndicator = false

        assignButton.setTitle(LocalizationKeys.assignToWorker.rawValue.localizeString(), for: .normal)
        rejectButton.setTitle(LocalizationKeys.reject.rawValue.localizeString(), for: .normal)
        
        type = .tenant
        viewModel.complaintDetail.bind { [unowned self] detail in
            DispatchQueue.main.async {
                guard let _ = detail else {return}
                self.stopAnimation()
                self.updateUI()
            }
        }
        
        viewModel.reject.bind { [unowned self] reject in
            guard let reject = reject else{return}
            self.stopAnimation()
            if reject.success == true{
                if let homeVC = self.navigationController?.viewControllers.filter({ $0 is CompanyHomeViewController }).first {
                    NotificationCenter.default.post(name: NSNotification.Name(Constants.reloadCompanyComplaints), object: nil)
                            self.navigationController?.popToViewController(homeVC, animated: true)
                    }
            }
            else{
                showAlert(message: reject.message ?? "")
            }
        }
        
        self.animateSpinner()
        viewModel.getComplaints(complaintID: complaintID ?? 0)
    }
    
    private func updateUI(){
        complaintTitleLabel.text = viewModel.getTitle()
        propertyValueLabel.text = "\(viewModel.getProperty() ?? "")"
        statusValueLabel.text = viewModel.getStatus()
        postedValueLabel.text = viewModel.getPostedDate()
        acceptedValueLabel.text = viewModel.getCompanyAcceptedDate()
        descriptionTextView.text = viewModel.getDescription()
        tenantValueLabel.text = viewModel.getTenantNameContact()
        dateValueLabel.text = viewModel.getScheduleTime()
        scheduleValueLabel.text = viewModel.getScheduleDate()
        personValueLabel.text = viewModel.getAssignWorkerContact()
        acceptedView.isHidden = viewModel.hideAcceptedView()
        scheduleView.isHidden = viewModel.hideScheduleView()
        viewMoreButtonView.isHidden = viewModel.showMore()
        descriptionView.isHidden = !viewModel.showMore()
        workerPhotoView.isHidden = viewModel.hideWorkerPhotoView()
        buttonsView.isHidden = viewModel.hideButtonsView()

        self.collectionView.reloadData()
        self.workerCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == workerCollectionView{
            return viewModel.getWorkerPhotoCount()
        }
        else{
            return viewModel.getComplaintPhotoCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplainDetailCollectionViewCell.identifier, for: indexPath)as! ComplainDetailCollectionViewCell
        if collectionView == workerCollectionView{
            cell.configure(with: viewModel.getPhotoForCompleted(index: indexPath.row))
        }
        else{
            cell.configure(with: viewModel.getPhoto(index: indexPath.row))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoPhotoViewer(delegate: self, photos: collectionView == workerCollectionView ? viewModel.getAllWorkerPhoto() : viewModel.getAllTenantPhoto())
    }

    
    @IBAction func assignBtnAction(_ sender: Any) {
        guard let complaintDetail = viewModel.getComplaint() else { return }
        Switcher.gotoAssignWorker(delegate: self, complaint: complaintDetail)
    }
    
    @IBAction func rejectBtnAction(_ sender: Any) {
        self.animateSpinner()
        viewModel.reject(complaintID: complaintID ?? 0)
    }
    
    @IBAction func showMoreBtnAction(_ sender: Any) {
        viewMoreButtonView.isHidden = !viewMoreButtonView.isHidden
        descriptionView.isHidden = !descriptionView.isHidden
    }
}

extension CompanyPendingController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.83, height: 76.83)
    }
}

