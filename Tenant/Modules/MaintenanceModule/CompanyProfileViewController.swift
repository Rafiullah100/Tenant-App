//
//  CompanyProfileViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/5/24.
//

import UIKit
import GoogleMaps
class CompanyProfileViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CompanyProfileTableViewCell", bundle: nil), forCellReuseIdentifier: CompanyProfileTableViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.setImage(UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en"), for: .normal)
        backLabel.text = LocalizationKeys.editProfile.rawValue.localizeString()
        titleLabel.text = LocalizationKeys.title.rawValue.localizeString()
        numberLabel.text = LocalizationKeys.contactNumber.rawValue.localizeString()
        branchLabel.text = LocalizationKeys.branches.rawValue.localizeString()
        buttonLabel.text = LocalizationKeys.addBranches.rawValue.localizeString()
        mapLabel.text = LocalizationKeys.googleMapLoc.rawValue.localizeString()

        
        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 6.0)
        mapView.camera = camera
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
}

extension CompanyProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyProfileTableViewCell.cellReuseIdentifier(), for: indexPath) as! CompanyProfileTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}
