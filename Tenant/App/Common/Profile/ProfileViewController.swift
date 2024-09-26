//
//  ProfileViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 9/26/24.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    private var viewModel = ProfileViewModel()

    var pickerView = UIPickerView()
    var userType: UserType?
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .company

        viewModel.profile.bind { [unowned self] profile in
            guard let _ = profile else {return}
            self.stopAnimation()
            self.updateUI()
        }
        self.animateSpinner()
        viewModel.getProfile(userID: UserDefaults.standard.userID ?? 0, userType: userType ?? .tenant)
    }
    
    private func updateUI(){
        nameTextField.text = viewModel.getName()
        contactTextField.text = viewModel.getContact()
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (viewModel.getProfileImage())), placeholderImage: UIImage(named: "PlaceholderImage"))
    }
    
    @IBAction func takePhotoBtn(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
//        let profile = CompanyUpdateProfileInputModel(name: nameTextField.text ?? "", locationCode: locationCodeTextField.text ?? "", city: viewModel.getCity(), district: viewModel.getDistrict())
//        let validationResponse = viewModel.isFormValid(profile: profile)
//        if validationResponse.isValid {
//            self.animateSpinner()
//            self.viewModel.updateProfile(image: imageView.image ?? UIImage())
//        }
//        else{
//            showAlert(message: validationResponse.message)
//        }
    }

}

extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
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
