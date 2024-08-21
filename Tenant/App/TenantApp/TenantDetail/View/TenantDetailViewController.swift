//
//  ComplainDetailViewController.swift
//  Raabt
//
//  Created by Ngc on 28/06/2024.
//

import UIKit

class TenantDetailViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
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
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var complaintTitleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var scheduleView: UIView!
   
    @IBOutlet weak var scheduleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var personLbl: UILabel!
    
    private var viewModel = TenantComplaintDetailViewModel()
    var complaintID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = LocalizationKeys.description.rawValue.localizeString()
        complaintIdLabel.text = LocalizationKeys.complaintID.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.photos.rawValue.localizeString()
        postLabel.text = LocalizationKeys.posted.rawValue.localizeString()
        
        scheduleLabel.text = LocalizationKeys.schedule.rawValue.localizeString()
        timeLabel.text = LocalizationKeys.dateAndTime.rawValue.localizeString()
        personLabel.text = LocalizationKeys.person.rawValue.localizeString()
        
        doneButton.setTitle(LocalizationKeys.done.rawValue.localizeString(), for: .normal)
        collectionView.showsVerticalScrollIndicator = false
        type = .tenant
        
        viewModel.complaintDetail.bind { [unowned self] detail in
            DispatchQueue.main.async {
                guard let _ = detail else {return}
                self.stopAnimation()
                self.updateUI()
                self.collectionView.reloadData()
            }
        }
        self.animateSpinner()
        viewModel.getComplaints(complaintID: complaintID ?? 0)
    }
    
    private func updateUI(){
        complaintTitleLabel.text = viewModel.getTitle()
        idLabel.text = "\(viewModel.getCompalintID())"
        statusLbl.text = viewModel.getStatus()
        descriptionLbl.text = viewModel.getDescription()
        dateLabel.text = viewModel.getPostedDate()
        scheduleLbl.text = viewModel.getScheduleDate()
        timeLbl.text = viewModel.getScheduleTime()

        //show if worker id is not null and complete task is zero
        if viewModel.getWorkerID() == 1 && viewModel.isTaskCompleted() == 0{
            scheduleView.isHidden = false
        }
        else {
            scheduleView.isHidden = true
        }
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
}

extension TenantDetailViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.83, height: 76.83)
    }
}

