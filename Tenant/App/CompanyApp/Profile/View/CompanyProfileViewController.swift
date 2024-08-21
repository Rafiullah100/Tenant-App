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
    }
    
    private func updateUI(){
        nameTextField.text = viewModel.getName()
        contactTextField.text = viewModel.getContact()
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (viewModel.getProfileImage())), placeholderImage: UIImage(named: "placeholder"))
        branches = viewModel.getBranchesList()
        Helper.shared.getCoordinates(for: "1 Infinite Loop, CA, USA") { coordinate in
            guard let coordinate = coordinate else{
                self.showAlert(message: "Incorrect location")
                return
            }
            let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6.0)
            self.mapView.camera = camera
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func takePhotoBtn(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
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
