//
//  AddBranchViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/6/24.
//

import UIKit
import GoogleMaps
class AddBranchViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CompanyProfileTableViewCell", bundle: nil), forCellReuseIdentifier: CompanyProfileTableViewCell.cellReuseIdentifier())
        }
    }  
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!

    var branchesList = [CompanyBranch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        branchLabel.text = LocalizationKeys.branches.rawValue.localizeString()
        print(branchesList)
        viewModel.added.bind { [unowned self] branch in
            guard let branch = branch else {return}
            self.stopAnimation()
            if branch.success == true{
                branchesList.append(CompanyBranch(id: 0, companyID: 0, name: nameTextField.text, contact: contactTextField.text, locationCode: addressTextField.text, district: viewModel.getDistrict(), city: viewModel.getCity(), timestamp: ""))
                NotificationCenter.default.post(name: NSNotification.Name(Constants.reloadBranches), object: nil)
                self.nameTextField.text = ""
                self.contactTextField.text = ""
                self.addressTextField.text = ""
                self.tableView.reloadData()
            }
            else{
                showAlert(message: branch.message ?? "")
            }
        }
        
        viewModel.address.bind {  [unowned self] address in
            guard let _ = address else {return}
            self.stopAnimation()
            setupMap(lat: viewModel.getCoordinatesFromCode().0, lng: viewModel.getCoordinatesFromCode().1)
        }
    }
    
    private var viewModel = AddBranchViewModel()
    var companyID: Int?
    
    @IBAction func confirmBtnAction(_ sender: Any) {
        if addressTextField.text == nil {
            showAlert(message: "Please enter location code and try again.")
        }
        else{
            self.animateSpinner()
            viewModel.getAddress(locationCode: addressTextField.text ?? "")
        }
    }
    @IBAction func addBtnAction(_ sender: Any) {
        let branch = AddBranchInputModel(companyID: UserDefaults.standard.userID ?? 0, name: nameTextField.text ?? "", locationCode: addressTextField.text ?? "", mobile: contactTextField.text ?? "", district: viewModel.getDistrict(), city: viewModel.getCity())
        let validationResponse = viewModel.isFormValid(branch: branch)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.addBranch()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    private func setupMap(lat: Double, lng: Double){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 14.0)
        mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat,
                                                 longitude: lng)
        marker.icon = UIImage(named: "pin")
        marker.map = mapView
    }
}

extension AddBranchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyProfileTableViewCell.cellReuseIdentifier(), for: indexPath) as! CompanyProfileTableViewCell
        cell.branch = branchesList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
