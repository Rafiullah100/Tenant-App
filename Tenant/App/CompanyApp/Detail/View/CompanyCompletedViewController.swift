//
//  MainCompStatusViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/9/24.
//

import UIKit

class CompanyCompletedViewController: BaseViewController {
    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var complaintTypeLabel: UILabel!
    @IBOutlet weak var postedValueLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var tenantValueLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
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
    private var viewModel = CompanyDetailViewModel()
    var complaintID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = false

        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        postedLabel.text = LocalizationKeys.postedOn.rawValue.localizeString()
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.uploadedByWorker.rawValue.localizeString()
        propertyLabel.text = LocalizationKeys.property.rawValue.localizeString()
        tenantLabel.text = LocalizationKeys.tenant.rawValue.localizeString()
        scheduleLabel.text = LocalizationKeys.schedule.rawValue.localizeString()
        dateLabel.text = LocalizationKeys.dateAndTime.rawValue.localizeString()
        personLabel.text = LocalizationKeys.person.rawValue.localizeString()
        acceptedLabel.text = LocalizationKeys.acceptedOn.rawValue.localizeString()
        type = .tenant
        
        viewModel.complaintDetail.bind { [unowned self] detail in
            DispatchQueue.main.async {
                guard let _ = detail else {return}
                self.stopAnimation()
//                self.updateUI()
                self.collectionView.reloadData()
            }
        }
        self.animateSpinner()
        viewModel.getComplaints(complaintID: complaintID ?? 0)
    }
    
//    private func updateUI(){
////        complaintTitleLabel.text = viewModel.getTitle()
////        propertyValueLabel.text = "\(viewModel.getCompalintID())"
//        statusValueLabel.text = viewModel.getStatus()
//        dateLabel.text = viewModel.getPostedDate()
//        scheduleLbl.text = viewModel.getScheduleDate()
//        timeLbl.text = viewModel.getScheduleTime()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

}

extension CompanyCompletedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier(), for: indexPath)as! ComplaintCollectionViewCell
//        cell.configure(with: UIImage(named: "Img1")!)
        return cell
        
    }
}


extension CompanyCompletedViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.83, height: 76.83)
    }
}
