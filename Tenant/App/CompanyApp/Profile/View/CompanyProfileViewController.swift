//
//  CompanyProfileViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/5/24.
//

import UIKit
import GoogleMaps
class CompanyProfileViewController: BaseViewController {
    @IBOutlet weak var titlLabel: UILabel!
    
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapLabel: UILabel!

    @IBOutlet weak var numberLabel: UILabel!
  
    @IBOutlet weak var locationCodeTextField: UITextField!
    var pickerView = UIPickerView()
    private var viewModel = CompanyProfileViewModel()

    @IBOutlet weak var mapView: GMSMapView!
    
    var branches = [CompanyBranch]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlLabel.text = LocalizationKeys.title.rawValue.localizeString()
        numberLabel.text = LocalizationKeys.contactNumber.rawValue.localizeString()
        
        mapLabel.text = LocalizationKeys.googleMapLoc.rawValue.localizeString()
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        type = .company
        viewControllerTitle = LocalizationKeys.editProfile.rawValue.localizeString()
        viewModel.profile.bind { [unowned self] profile in
            guard let _ = profile else {return}
            self.stopAnimation()
            self.updateUI()
        }
        self.animateSpinner()
        viewModel.getProfile(companyID: UserDefaults.standard.userID ?? 0)
        
        viewModel.address.bind {  [unowned self] address in
            guard let address = address else {return}
            self.stopAnimation()
            setupMap(lat: viewModel.getCoordinatesFromCode().0, lng: viewModel.getCoordinatesFromCode().1)
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
    
    private func updateUI(){
        nameTextField.text = viewModel.getName()
        contactTextField.text = viewModel.getContact()
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (viewModel.getProfileImage())), placeholderImage: UIImage(named: "PlaceholderImage"))
        branches = viewModel.getBranchesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func confirmBtnAction(_ sender: Any) {
        if locationCodeTextField.text == nil {
            showAlert(message: "Please enter location code and try again.")
        }
        else{
            self.animateSpinner()
            viewModel.getAddress(locationCode: locationCodeTextField.text ?? "")
        }
    }
    
    @IBAction func takePhotoBtn(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
    }
}

extension CompanyProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
