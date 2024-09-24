//
//  WorkerPropertyViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 9/24/24.
//


import UIKit
import GoogleMaps
class WorkerPropertyViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
        collectionView.register(ComplaintCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier())
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
    @IBOutlet weak var AddressStaticLabel: UILabel!
    @IBOutlet weak var propertyStaticLabel: UILabel!
    @IBOutlet weak var flatStaticLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var propertyTitleLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    var propertyDetail: Property?
    var viewModel: WorkerPropertyViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .company
        mapView.layer.cornerRadius = 5.0
        guard let propertyDetail = propertyDetail else { return }
        viewModel = WorkerPropertyViewModel(property: propertyDetail)
        
        viewModel.address.bind {  [unowned self] address in
            guard let _ = address else {return}
            self.stopAnimation()
            setupMap()
            self.collectionView.reloadData()
        }
        
        self.animateSpinner()
        viewModel.getAddress(locationCode: viewModel.getLocationCode())
    }
    
    private func setupMap(){
        let camera = GMSCameraPosition.camera(withLatitude: viewModel.getCoordinates().0, longitude: viewModel.getCoordinates().1, zoom: 14.0)
        mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: viewModel.getCoordinates().0,
                                                 longitude: viewModel.getCoordinates().1)
        marker.icon = UIImage(named: "pin")
        marker.map = mapView
        addressLabel.text = viewModel.getAddress()
        propertyTitleLabel.text = viewModel.getPropertyTitle()
        typeLabel.text = viewModel.getBuildingType()
        flatStaticLabel.text = viewModel.isPropertyBuilding()
        flatLabel.text = viewModel.getBuildingNumber()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension WorkerPropertyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPropertyImageCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplaintCollectionViewCell.cellReuseIdentifier(), for: indexPath)as! ComplaintCollectionViewCell
        cell.configure(with: viewModel?.getPropertyImageUrl(at: indexPath.row) ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoPhotoViewer(delegate: self, propertyImages: viewModel.getPropertyImages() , position: indexPath)
    }
}

extension WorkerPropertyViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
