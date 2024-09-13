//
//  StatusDoneViewController.swift
//  Raabt
//
//  Created by Ngc on 01/07/2024.
//

import UIKit

class TenantCompletedViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var complaintTitleLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var complaintIdLabel: UILabel!
    
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
    @IBOutlet weak var personLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var scheduleLbl: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
   
    @IBOutlet weak var complaintPhtotoView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var companyPhotoView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ComplainDetailCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplainDetailCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var companyCollectionView: UICollectionView!{
        didSet{
            companyCollectionView.register(ComplainDetailCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplainDetailCollectionViewCell.identifier)
            companyCollectionView.delegate = self
            companyCollectionView.dataSource = self
        }
    }

    private var viewModel = TenantComplaintDetailViewModel()
    var complaintID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        complaintIdLabel.text = LocalizationKeys.complaintID.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
//        photoLabel.text = LocalizationKeys.photosUploaded.rawValue.localizeString()
        confirmButton.setTitle(LocalizationKeys.confirm.rawValue.localizeString(), for: .normal)
        scheduleLabel.text = LocalizationKeys.schedule.rawValue.localizeString()
        dateLabel.text = LocalizationKeys.dateAndTime.rawValue.localizeString()
        personLabel.text = LocalizationKeys.person.rawValue.localizeString()
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        postLabel.text = LocalizationKeys.posted.rawValue.localizeString()

        type = .tenant
        viewModel.complaintDetail.bind { [unowned self] detail in
            guard let _ = detail else {return}
            self.stopAnimation()
            self.updateUI()
        }
        self.animateSpinner()
        viewModel.getComplaints(complaintID: complaintID ?? 0)
        confirmWork()
    }
    
    private func confirmWork(){
        viewModel.confirm.bind { [unowned self] confirm in
            guard let confirm = confirm else {return}
            self.stopAnimation()
            if confirm.success == true{
                showAlertWithbutttons(message: confirm.message ?? "") {
                    NotificationCenter.default.post(name: NSNotification.Name(Constants.reloadTenantComplaints), object: nil)
                    NotificationCenter.default.post(name: NSNotification.Name(Constants.reloadSelfComplaints), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                showAlert(message: confirm.message ?? "")
            }
        }
    }
    
    private func updateUI(){
        complaintTitleLabel.text = viewModel.getTitle()
        idLabel.text = "\(viewModel.getCompalintID())"
        statusLbl.text = viewModel.getStatus()
        descriptionLbl.text = viewModel.getDescription()
        scheduleLbl.text = viewModel.getScheduleDate()
        timeLbl.text = viewModel.getScheduleTime()
        personLbl.text = viewModel.getMaintenancePersonContact()
        phoneLbl.text = viewModel.getContacts()
        dateLabel.text = viewModel.getPostedDate()
        scheduleView.isHidden = viewModel.hideScheduleView()
        confirmView.isHidden = viewModel.hideConfirmView()
        complaintPhtotoView.isHidden = viewModel.hideComplaintPhotoView()
        companyPhotoView.isHidden = viewModel.hideCompanyPhotoView()
        personLbl.text = viewModel.getAssignWorkerContact()
        moreButton.isHidden = viewModel.showMore()
        complaintPhtotoView.isHidden = !viewModel.showMore()
        descriptionView.isHidden = !viewModel.showMore()

        self.collectionView.reloadData()
        self.companyCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == companyCollectionView{
            return viewModel.getPhotosForCompletedCount()
        }
        else{
            return viewModel.getPhotosCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplainDetailCollectionViewCell.identifier, for: indexPath)as! ComplainDetailCollectionViewCell
        if collectionView == companyCollectionView{
            cell.configure(with: viewModel.getPhotoForCompleted(index: indexPath.row))
        }
        else{
            cell.configure(with: viewModel.getPhoto(index: indexPath.row))
        }
        return cell
    }
 
    @IBAction func showMoreBtnAction(_ sender: Any) {
        complaintPhtotoView.isHidden = !complaintPhtotoView.isHidden
        descriptionView.isHidden = !descriptionView.isHidden
    }
    
    @IBAction func confirmBtnAction(_ sender: Any) {
        self.animateSpinner()
        viewModel.confirm(complaintID: complaintID ?? 0)
    }
}

extension TenantCompletedViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
