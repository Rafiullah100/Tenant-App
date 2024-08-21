//
//  CompanyDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/7/24.
//

import UIKit
import GoogleMaps
class CompanyDetailViewController: BaseViewController {

    @IBOutlet weak var titlLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CompanyProfileTableViewCell", bundle: nil), forCellReuseIdentifier: CompanyProfileTableViewCell.cellReuseIdentifier())
        }
    }
    var pickerView = UIPickerView()

    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        titlLabel.text = LocalizationKeys.title.rawValue.localizeString()
//        numberLabel.text = LocalizationKeys.contactNumber.rawValue.localizeString()
//        branchLabel.text = LocalizationKeys.branches.rawValue.localizeString()
//        mapLabel.text = LocalizationKeys.googleMapLoc.rawValue.localizeString()

        tableView.showsVerticalScrollIndicator = false

        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 6.0)
        mapView.camera = camera
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        type = .company
//        viewControllerTitle = LocalizationKeys.editProfile.rawValue.localizeString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
  

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
}

extension CompanyDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyProfileTableViewCell.cellReuseIdentifier(), for: indexPath) as! CompanyProfileTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
