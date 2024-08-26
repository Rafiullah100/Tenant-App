//
//  MaintenaceDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/8/24.
//

import UIKit

class CompanyPendingController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var postedValueLabel: UILabel!
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
    @IBOutlet weak var complaintIdLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var tenantLabel: UILabel!
    @IBOutlet weak var assignButton: UIButton!
    
    var complaintID: Int?
    private var viewModel = CompanyDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        complaintIdLabel.text = LocalizationKeys.complaintID.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.photos.rawValue.localizeString()
        postLabel.text = LocalizationKeys.posted.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        collectionView.showsVerticalScrollIndicator = false

        assignButton.setTitle(LocalizationKeys.assignToWorker.rawValue.localizeString(), for: .normal)
        rejectButton.setTitle(LocalizationKeys.reject.rawValue.localizeString(), for: .normal)
        
        type = .tenant
        viewModel.complaintDetail.bind { [unowned self] detail in
            DispatchQueue.main.async {
                guard let _ = detail else {return}
                self.stopAnimation()
                self.updateUI()
                self.collectionView.reloadData()
            }
        }
        
        viewModel.reject.bind { [unowned self] reject in
            guard let reject = reject else{return}
                self.stopAnimation()
            showAlert(message: reject.message ?? "")
        }
        
        self.animateSpinner()
        viewModel.getComplaints(complaintID: complaintID ?? 0)
    }
    
    private func updateUI(){
        complaintTitleLabel.text = viewModel.getTitle()
//        propertyValueLabel.text = "\(viewModel.getCompalintID())"
        statusValueLabel.text = viewModel.getStatus()
        postedValueLabel.text = viewModel.getPostedDate()
        descriptionTextView.text = viewModel.getDescription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPhotosForInProgressComplaint().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplainDetailCollectionViewCell.identifier, for: indexPath)as! ComplainDetailCollectionViewCell
        cell.configure(with: viewModel.getPhoto(index: indexPath.row))
        return cell
    }
    
    @IBAction func assignBtnAction(_ sender: Any) {
        Switcher.gotoAssignWorker(delegate: self, complaintID: complaintID ?? 0)
    }
    
    @IBAction func rejectBtnAction(_ sender: Any) {
        self.animateSpinner()
        viewModel.reject(complaintID: complaintID ?? 0)
    }
}

extension CompanyPendingController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.83, height: 76.83)
    }
}

