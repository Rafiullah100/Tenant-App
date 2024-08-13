//
//  StatusDoneViewController.swift
//  Raabt
//
//  Created by Ngc on 01/07/2024.
//

import UIKit

class TenantCompletedViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var complaintTitleLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var complaintIdLabel: UILabel!
    
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
    @IBOutlet weak var personLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var scheduleLbl: UILabel!
    
    private var viewModel = TenantComplaintDetailViewModel()
    var complaintID: Int?
    
    @IBOutlet weak var collectionViewDone: UICollectionView!{
        didSet{
            collectionViewDone.register(StatusDoneCollectionViewCell.nib(), forCellWithReuseIdentifier: StatusDoneCollectionViewCell.identifier)
            collectionViewDone.delegate = self
            collectionViewDone.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        complaintIdLabel.text = LocalizationKeys.complaintID.rawValue.localizeString()
        statusLabel.text = LocalizationKeys.status.rawValue.localizeString()
        photoLabel.text = LocalizationKeys.photosUploaded.rawValue.localizeString()
        confirmButton.setTitle(LocalizationKeys.confirm.rawValue.localizeString(), for: .normal)
        scheduleLabel.text = LocalizationKeys.schedule.rawValue.localizeString()
        dateLabel.text = LocalizationKeys.dateAndTime.rawValue.localizeString()
        personLabel.text = LocalizationKeys.person.rawValue.localizeString()
        
        collectionViewDone.showsVerticalScrollIndicator = false

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
        complaintTitleLabel.text = viewModel.getTitle()
        idLabel.text = "\(viewModel.getCompalintID())"
        statusLbl.text = viewModel.getStatus()
//        descriptionLbl.text = viewModel.getDescription()
        scheduleLbl.text = viewModel.getScheduleDate()
        timeLbl.text = viewModel.getScheduleTime()
        if viewModel.isTaskCompleted() == 0{
            confirmView.isHidden = true
        }
        else {
            confirmView.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusDoneCollectionViewCell.identifier, for: indexPath)as! StatusDoneCollectionViewCell
            
            cell.configure(with: UIImage(named: "Img1")!)
          
            
            return cell
            
        }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TenantCompletedViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.83, height: 76.83)
    }
}
