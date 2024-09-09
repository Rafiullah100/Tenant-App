//
//  AddPropertyViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/12/24.
//

import UIKit
import GoogleMaps


protocol AddPropertyDelegate {
    func propertyAdded()
}

class AddPropertyViewController: BaseViewController {

    @IBOutlet weak var villaImageView: UIImageView!
    @IBOutlet weak var buildingImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var villaLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var tradeLabel: UILabel!
    @IBOutlet weak var propertyTextField: UITextField!
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var scrollView: UIScrollView!
    var buildingType: PropertyType?
    private var viewModel = AddPropertyViewModel()

    var delegate: AddPropertyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextField.text = "RHMA7335"
        titlLabel.text = LocalizationKeys.addNewProperty.rawValue.localizeString()
        propertyTextField.placeholder = LocalizationKeys.enterPropertyTitle.rawValue.localizeString()
        propertyTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        tradeLabel.text = LocalizationKeys.selectTrade.rawValue.localizeString()
        locationLabel.text = LocalizationKeys.locationCode.rawValue.localizeString()
        locationTextField.placeholder = LocalizationKeys.enterLocationCode.rawValue.localizeString()
        locationTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        cityTextField.placeholder = LocalizationKeys.enterCity.rawValue.localizeString()
        cityTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        districtTextField.placeholder = LocalizationKeys.enterDistrict.rawValue.localizeString()
        districtTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        mapLabel.text = LocalizationKeys.googleMapLocation.rawValue.localizeString()
        confirmButton.setTitle(LocalizationKeys.confirmLocation.rawValue.localizeString(), for: .normal)
        addButton.setTitle(LocalizationKeys.addProperty.rawValue.localizeString(), for: .normal)
        cancelButton.setTitle(LocalizationKeys.cancel.rawValue.localizeString(), for: .normal)
        propertyLabel.text = LocalizationKeys.propertyTitle.rawValue.localizeString()
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        
        buildingType = .building
        selectPopertyType()
        
        type = .tenant
        
        viewModel.add.bind { [unowned self] add in
            guard let add = add else {return}
            DispatchQueue.main.async {
                self.stopAnimation()
                if add.success == true{
                    self.showAlertWithbutttons(message: add.message ?? "") {
                        NotificationCenter.default.post(name: Notification.Name(Constants.reloadProperties), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                else{
                    self.showAlert(message: add.message ?? "")
                }
            }
        }
        
        
        viewModel.address.bind {  [unowned self] address in
            guard let _ = address else {return}
            self.stopAnimation()
            self.cityTextField.text = self.viewModel.getCity()
            self.districtTextField.text = self.viewModel.getDistrict()
            setupMap()
        }
        
        setupMap()
    }
    
    private func setupMap(){
        let camera = GMSCameraPosition.camera(withLatitude: viewModel.getCoordinates().0, longitude: viewModel.getCoordinates().1, zoom: 14.0)
        mapView.camera = camera
        
//        let marker = GMSMarker()
//
//        marker.position = CLLocationCoordinate2D(latitude: viewModel.getCoordinates().0,
//                                                 longitude: viewModel.getCoordinates().1)
//        marker.icon = UIImage(named: "pin")
//        marker.map = mapView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func villaBtnAction(_ sender: Any) {
        buildingType = .villa
        selectPopertyType(type: .villa)
    }
    
    @IBAction func buildingBtnAction(_ sender: Any) {
        buildingType = .building
        selectPopertyType(type: .building)
    }
    
    @IBAction func confirmLocationBtnAction(_ sender: Any) {
        if locationTextField.text == nil {
            showAlert(message: "Please enter location code and try again.")
        }
        else{
            self.animateSpinner()
            viewModel.getAddress(locationCode: locationTextField.text ?? "")
        }
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        let property = AddPropertyInputModel(name: propertyTextField.text ?? "", buildingType: buildingType?.rawValue ?? "", locationCode: locationTextField.text ?? "", city: cityTextField.text ?? "", district: districtTextField.text ?? "")
        let validationResponse = viewModel.isFormValid(property: property)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.addProperty()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    private func selectPopertyType(type: PropertyType = .building){
        switch type {
        case .building:
            villaImageView.image = UIImage(named: "circle-empty")
            buildingImageView.image = UIImage(named: "circle-fill")
        case .villa:
            buildingImageView.image = UIImage(named: "circle-empty")
            villaImageView.image = UIImage(named: "circle-fill")
        }
    }
}
