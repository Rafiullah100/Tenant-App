//
//  OwnerDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/20/24.
//

import UIKit

class OwnerDetailViewController: BaseViewController {
    @IBOutlet weak var postedValueLabel: UILabel!
    @IBOutlet weak var timeValueLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var companyPhotoLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var companyAcceptedView: UIView!
    @IBOutlet weak var approveView: UIView!
    @IBOutlet weak var personValueLabel: UILabel!
    @IBOutlet weak var scheduleValueLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var tenantValueLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
    @IBOutlet weak var complaintTitleLabel: UILabel!
    
    @IBOutlet weak var acceptedValueLabel: UILabel!
    @IBOutlet weak var approvedValueLabel: UILabel!
    @IBOutlet weak var completedValueLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var approveLabel: UILabel!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var companyPhotoView: UIView!
    @IBOutlet weak var tenantPhotoView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
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
    
    private var viewModel = OwnerDetailViewModel()
    var complaintID: Int?
    private var isExpanded = false

    @IBOutlet weak var companyAcceptedLabel: UILabel!
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
        approveLabel.text = LocalizationKeys.approvedOn.rawValue.localizeString()
        companyAcceptedLabel.text = LocalizationKeys.companyAcceptedOn.rawValue.localizeString()
        approveButton.setTitle(LocalizationKeys.approve.rawValue.localizeString(), for: .normal)
        rejectButton.setTitle(LocalizationKeys.reject.rawValue.localizeString(), for: .normal)
        photoLabel.text = LocalizationKeys.photoUploadedByTenant.rawValue.localizeString()
        companyPhotoLabel.text = LocalizationKeys.photoUploadedByCompany.rawValue.localizeString()
        completedLabel.text = LocalizationKeys.completedOn.rawValue.localizeString()

        type = .tenant
        
        viewModel.complaintDetail.bind { [weak self] details in
            guard let _ = details else {return}
            DispatchQueue.main.async {
                self?.stopAnimation()
                self?.updateUI()
            }
        }
        
        viewModel.approve.bind { [weak self] approve in
            guard let approve = approve else {return}
            DispatchQueue.main.async {
                self?.stopAnimation()
                if approve.success == true{
                    self?.showAlertWithbutttons(message: approve.message ?? "") {
                        NotificationCenter.default.post(name: Notification.Name(Constants.reloadOwnerComplaints), object: nil)
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
                else{
                    self?.showAlert(message: approve.message ?? "")
                }
            }
        }
        
        self.animateSpinner()
        viewModel.getComplaints(complaintID: complaintID ?? 0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textViewTapped))
        textView.addGestureRecognizer(tapGesture)
        textView.isUserInteractionEnabled = true
    }
    
    @objc func textViewTapped() {
            if isExpanded {
                textView.text = viewModel.getDescription()
            } else {
                textView.text = "Click to view desciption."
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            isExpanded.toggle()
        }

    
    private func updateUI(){
        completedView.isHidden = viewModel.hideCompletedView()
        companyAcceptedView.isHidden = viewModel.hideAcceptedView()
        scheduleView.isHidden = viewModel.hideScheduleView()
        buttonsView.isHidden = viewModel.hideApproveButtonView()
        approveView.isHidden = viewModel.hideApproveView()
        companyPhotoView.isHidden = viewModel.hideCompanyPhotoView()

        approveLabel.text = viewModel.isRejected() == true ? LocalizationKeys.rejectedOn.rawValue.localizeString() : LocalizationKeys.approvedOn.rawValue.localizeString()
        complaintTitleLabel.text = viewModel.getTitle()
        statusValueLabel.text = viewModel.getStatus()
        postedValueLabel.text = viewModel.getPostedDate()
        approvedValueLabel.text = viewModel.getOwnerApprovalDate()
        acceptedValueLabel.text = viewModel.getCompanyAcceptedDate()
        scheduleValueLabel.text = viewModel.getScheduleDate()
        timeValueLabel.text = viewModel.getScheduleTime()
        tenantValueLabel.text = viewModel.getTenant()
        propertyValueLabel.text = viewModel.getProperty()
        personValueLabel.text = viewModel.getAssignWorkerContact()
        completedValueLabel.text = viewModel.getCompletedDate()
        tenantCollectionView.reloadData()
        companyCollectionView.reloadData()
    }
    
    @IBAction func rejectBtnAction(_ sender: Any) {
        changeStatus(status: .reject)
    }
    
    @IBAction func approveBtnAction(_ sender: Any) {
        changeStatus(status: .approve)
    }
    
    private func changeStatus(status: OwnerApprovalType){
        self.animateSpinner()
        viewModel.changeStatus(complaintID: complaintID ?? 0, action: status.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension OwnerDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tenantCollectionView {
            return viewModel.getTenantPhotoCount()
        }
        else{
            return viewModel.getCompanyPhotoCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier(), for: indexPath)as! ComplaintCollectionViewCell
        if collectionView == tenantCollectionView {
            cell.configure(with: viewModel.getTenantPhoto(index: indexPath.row))
        }
        else{
            cell.configure(with: viewModel.getCompanyPhoto(index: indexPath.row))
        }
        return cell
    }
}


extension OwnerDetailViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
