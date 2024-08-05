//
//  AddPropertyViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/12/24.
//

import UIKit
import GoogleMaps
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 6.0)
        mapView.camera = camera
        
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
        
        selectPopertyType()
        
        type = .tenant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func villaBtnAction(_ sender: Any) {
        selectPopertyType(type: .villa)
    }
    
    @IBAction func buildingBtnAction(_ sender: Any) {
        selectPopertyType(type: .building)
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
