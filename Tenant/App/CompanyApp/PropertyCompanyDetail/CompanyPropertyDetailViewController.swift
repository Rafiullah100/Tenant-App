//
//  CompanyPropertyDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/7/24.
//

import UIKit
import GoogleMaps
class CompanyPropertyDetailViewController: BaseViewController {

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
//        let camera = GMSCameraPosition.camera(withLatitude: 34.0151, longitude: 71.5249, zoom: 6.0)
//        mapView.camera = camera
//        
//        propertyTitleLabel.text = property?.buildingNo
//        addressLabel.text = "\(property?.buildingType?.capitalized ?? "") \(property?.buildingNo ?? ""), \(property?.district ?? ""), \(property?.city ?? "")"
//        ownerLabel.text = property?.flats?[0].ownersTenants?.name
//        typeLabel.text = property?.buildingType?.capitalized
//        flatLabel.text = "\(property?.flats?.count ?? 0)"
        
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
        propertyTitleLabel.text = property?.buildingNo
        addressLabel.text = "\(property?.buildingType?.capitalized ?? "") \(property?.buildingNo ?? ""), \(property?.district ?? ""), \(property?.city ?? "")"
        ownerLabel.text = property?.flats?[0].ownersTenants?.name
        typeLabel.text = property?.buildingType?.capitalized
        flatLabel.text = "\(property?.flats?.count ?? 0)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }


}
