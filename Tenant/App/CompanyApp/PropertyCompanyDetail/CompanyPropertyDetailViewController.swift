//
//  CompanyPropertyDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/7/24.
//

import UIKit
import GoogleMaps
class CompanyPropertyDetailViewController: BaseViewController {

    @IBOutlet weak var AddressStaticLabel: UILabel!
    @IBOutlet weak var propertyStaticLabel: UILabel!
    @IBOutlet weak var ownerStaticLabel: UILabel!
    @IBOutlet weak var flatStaticLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var propertyTitleLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    var property: PropertiesRow?
    var viewModel = AddPropertyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .company
        mapView.layer.cornerRadius = 5.0
        AddressStaticLabel.text = LocalizationKeys.address.rawValue.localizeString()
        ownerStaticLabel.text = "\(LocalizationKeys.owner.rawValue.localizeString()):"
        propertyStaticLabel.text = LocalizationKeys.propertyType.rawValue.localizeString()
        flatStaticLabel.text = LocalizationKeys.totalFlats.rawValue.localizeString()

        viewModel.address.bind {  [unowned self] address in
            guard let _ = address else {return}
            self.stopAnimation()
            setupMap()
        }
        
        self.animateSpinner()
        print(property?.locationCode ?? "")
        viewModel.getAddress(locationCode: property?.locationCode ?? "")
    }
    
    private func setupMap(){
        let camera = GMSCameraPosition.camera(withLatitude: viewModel.getCoordinates().0, longitude: viewModel.getCoordinates().1, zoom: 14.0)
        mapView.camera = camera
        
        let marker = GMSMarker()
        
        marker.position = CLLocationCoordinate2D(latitude: viewModel.getCoordinates().0,
                                                 longitude: viewModel.getCoordinates().1)
        marker.icon = UIImage(named: "pin")
        marker.map = mapView
        
        propertyTitleLabel.text = "\(property?.title?.capitalized ?? ""), \(property?.buildingType?.capitalized ?? "") \(property?.buildingNo ?? ""), \(property?.district ?? ""), \(property?.city ?? "")"
        addressLabel.text = "\(property?.district ?? ""), \(property?.city ?? "")"
        typeLabel.text = property?.buildingType?.capitalized
        flatLabel.text = "\(property?.flats?.count ?? 0)"
        if property?.flats?.count ?? 0 > 0 {
            ownerLabel.text = property?.flats?[0].ownersTenants?.name
        }
        else{
            ownerLabel.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}
