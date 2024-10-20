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

class AddPropertyViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var fileButton: UIButton!
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var retrieveLocationButton: UIButton!
    @IBOutlet weak var noOfFileLabel: UILabel!
    @IBOutlet weak var villaImageView: UIImageView!
    @IBOutlet weak var buildingImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
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
    @IBOutlet weak var galleryView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ComplaintCollectionViewCell.nib(), forCellWithReuseIdentifier: ComplaintCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    var delegate: AddPropertyDelegate?
    var selectedImages = [UIImage]()
    var pickerView = UIPickerView()
    
    var buildingNumber: String?
    let imagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        locationTextField.text = "RHMA7335"
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
        addButton.setTitle(LocalizationKeys.addProperty.rawValue.localizeString(), for: .normal)
        cancelButton.setTitle(LocalizationKeys.cancel.rawValue.localizeString(), for: .normal)
        propertyLabel.text = LocalizationKeys.propertyTitle.rawValue.localizeString()
        retrieveLocationButton.setTitle(LocalizationKeys.retrieveLocation.rawValue.localizeString(), for: .normal)
        sizeLabel.text = LocalizationKeys.imageSize.rawValue.localizeString()
        noOfFileLabel.text = LocalizationKeys.noFileChoose.rawValue.localizeString()
        fileButton.setTitle(LocalizationKeys.chooseFile.rawValue.localizeString(), for: .normal)

        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        
        buildingType = .building
        selectPopertyType()
        
        type = .tenant
        
        viewModel.add.bind { [unowned self] add in
            guard let add = add else {return}
            DispatchQueue.main.async {
                self.stopAnimation()
                if add.success == true{
                    if self.buildingType == .villa {
                        UserDefaults.standard.ownerTotolFlats = (UserDefaults.standard.ownerTotolFlats ?? 0) + 1
                    }
                    UserDefaults.standard.ownerTotolProperties = (UserDefaults.standard.ownerTotolProperties ?? 0) + 1
                    ToastManager.shared.showToast(message: add.message ?? "")
                    NotificationCenter.default.post(name: Notification.Name(Constants.reloadProperties), object: nil)
                    NotificationCenter.default.post(name: Notification.Name(Constants.reloadOwnerProfile), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    ToastManager.shared.showToast(message: add.message ?? "")
                }
            }
        }
        
        viewModel.address.bind {  [unowned self] address in
            guard let _ = address else {return}
            self.stopAnimation()
            self.cityTextField.text = self.viewModel.getCity()
            self.districtTextField.text = self.viewModel.getDistrict()
            self.buildingNumber = self.viewModel.getBuildingNo()
            setupMap()
        }
        
        setupMap()
    }
    
    private func setupMap(){
        mapView.clear()
        let camera = GMSCameraPosition.camera(withLatitude: viewModel.getCoordinates().0, longitude: viewModel.getCoordinates().1, zoom: 14.0)
        mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: viewModel.getCoordinates().0,
                                                 longitude: viewModel.getCoordinates().1)
        marker.icon = UIImage(named: "pin")
        marker.map = mapView
    }
    
    private func hideGalleryView(){
        self.galleryView.isHidden = selectedImages.count == 0 ? true : false
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
    
    @IBAction func retrieveLocationBtnAction(_ sender: Any) {
        if locationTextField.text == "" {
            showAlert(message: LocalizationKeys.PleaseEnterLocation.rawValue.localizeString())
        }
        else{
            self.animateSpinner()
            viewModel.getAddress(locationCode: locationTextField.text ?? "")
        }
    }
    
    @IBAction func pickImages(_ sender: Any) {
        guard selectedImages.count != 3 else {
            ToastManager.shared.showToast(message: LocalizationKeys.uploadMaxThree.rawValue.localizeString())
            return }
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        let property = AddPropertyInputModel(name: propertyTextField.text ?? "", buildingType: buildingType?.rawValue ?? "", locationCode: locationTextField.text ?? "", buildingNo: buildingNumber ?? "", city: cityTextField.text ?? "", district: districtTextField.text ?? "", images: selectedImages.count)
        let validationResponse = viewModel.isFormValid(property: property)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.addProperty(image: selectedImages)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComplaintCollectionViewCell.identifier, for: indexPath)as! ComplaintCollectionViewCell
        cell.imageView.image = selectedImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoPhotoViewer(delegate: self, addComplaintPhoto: selectedImages, position: indexPath)
    }
}

extension AddPropertyViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

extension AddPropertyViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImages.append(image)
            collectionView.reloadData()
            self.noOfFileLabel.text = "\(selectedImages.count) \(LocalizationKeys.fileSelected.rawValue.localizeString())"
        }
        hideGalleryView()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
